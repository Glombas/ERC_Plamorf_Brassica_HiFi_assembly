#!/bin/bash
#SBATCH --job-name="nextdenovo"
#SBATCH -c 10                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 320G                                # memory pool for all cores
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/slurm-%j.err

export PATH=/hpc-home/glombik/mamba/envs/nextdenovoenv/bin/:$PATH

#also load minimap2
source package 222eac79-310f-4d4b-8e1c-0cece4150333

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/nextdenovo/rapa

nextDenovo run_config.cfg
