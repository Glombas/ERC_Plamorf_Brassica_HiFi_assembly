#!/bin/bash
#SBATCH --job-name="ragtag_nd_rapa"
#SBATCH -p jic-medium
#SBATCH --mem 60G                                # memory pool for all cores
#SBATCH -c 10
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring/ragtagslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring/ragtagslurm-%j.err


#load in conda env

export PATH=/hpc-home/glombik/mamba/envs/ragtagenv/bin/:$PATH

refs='/jic/scratch/groups/Richard-Morris/glombikm/references'
anchors='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/anchoring'
assembly='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa/02_rundir/03.ctg_graph'

cd $anchors

ragtag.py scaffold -t 10 -o rt_anchor_nd_rapa_chiifu $refs/Brapa_chiifu_v41_genome20230413.fasta $assembly/nd.asm.fasta
ragtag.py scaffold -t 10 -o rt_anchor_nd_rapa_z1 $refs/BrapaZ1_v2_chromosomes.fasta $assembly/nd.asm.fasta

