#!/bin/bash
#SBATCH --job-name="repeatmasker"
#SBATCH -c 24                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 70G                                # memory pool for all cores
#SBATCH -t 1-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/repeatmasker/napus_full/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/repeatmasker/napus_full/slurm-%j.err

#load repeatmasker conda env

export PATH=/hpc-home/glombik/mamba/envs/repmaskenv/bin/:$PATH

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/repeatmasker/

RepeatMasker -e rmblast -pa 6 -lib /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/rep_masking/rep_modeler/napus_expseudo/RM_116749.MonJan131513012025/consensi.fa.classified -nolow -norna -no_is -gff -html -excln /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/re_rt_anchor_napus_darmor/rt_darmor/full_ragtag.scaffold.fasta

