#!/bin/bash
#SBATCH --job-name="rep_model"
#SBATCH -c 48                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 180G                                # memory pool for all cores
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/rep_modeler/napus_expseudo/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/rep_modeler/napus_expseudo/slurm-%j.err

export PATH=/hpc-home/glombik/mamba/envs/repmodeler/bin/:$PATH

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/rep_modeler/napus_expseudo/

#BuildDatabase -name napus_expseudo /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/re_rt_anchor_napus_darmor/rt_darmor/expseudo_ragtag.scaffold.fasta

RepeatModeler -threads 48 -database napus_expseudo  -LTRStruct >& mamba_rep_model_run.out
