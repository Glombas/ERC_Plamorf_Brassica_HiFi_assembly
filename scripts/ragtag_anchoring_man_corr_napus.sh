#!/bin/bash
#SBATCH --job-name="ragtag_man_corr"
#SBATCH -p nbi-medium
#SBATCH --mem 65G                                # memory pool for all cores
#SBATCH -c 10
#SBATCH -t 0-03:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/re_rt_anchor_napus_darmor/ragtagslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/re_rt_anchor_napus_darmor/ragtagslurm-%j.err


#load in conda env

export PATH=/hpc-home/glombik/mamba/envs/ragtagenv/bin/:$PATH

refs='/jic/scratch/groups/Richard-Morris/glombikm/references'
anchors='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/re_rt_anchor_napus_darmor'

cd $anchors

ragtag.py scaffold -t 10 -o rt_darmor $refs/BnapusDarmor-bzh_chromosomes.fasta homcovBnapus_manual_corrected.fa
ragtag.py scaffold -t 10 -o rt_daae $refs/GCA_020379485.1_Da-Ae_genomic.fna homcovBnapus_manual_corrected.fa

