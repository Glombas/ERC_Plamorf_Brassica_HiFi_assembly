#!/bin/bash
#SBATCH --job-name="mummer"
#SBATCH -p jic-medium
#SBATCH --mem 40G                                # memory pool for all cores
#SBATCH -t 1-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring/mummer/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring/mummer/slurm-%j.err

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring/mummer/

source package eab121cb-2eb8-49c1-a9a5-a33754ea9fea #mummer
source package 09b2c824-1ef0-4879-b4d2-0a04ee1bbd6d #gnuplot

nucmer -p chiifu_rapa_mummer -l 100 /jic/scratch/groups/Richard-Morris/glombikm/references/Brapa_chiifu_v41_genome20230413.fasta /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring/rt_anchor_nd_rapa_chiifu/ragtag.scaffold.fasta


delta-filter -1  -i 90 -l 100 chiifu_rapa_mummer.delta > filtered_chiifu_rapa_mummer

