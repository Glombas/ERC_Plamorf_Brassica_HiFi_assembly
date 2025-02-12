#!/bin/bash
#SBATCH --job-name="hififilter"
#SBATCH -c 32                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 100G                                # memory pool for all cores
#SBATCH -t 0-10:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/slurm-%j.err

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq

source minimap2-2.26-r1175_CBG
source samtools-1.9

# blast
source package d6092385-3a81-49d9-b044-8ffb85d0c446
# bamtools
source package 9c36c962-3ae5-4f05-a17b-967eb76f9472
# pigz
source package 91a6ad6f-e2d0-49f2-86c9-90922841985d

export PATH=$PATH:/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/hi-fi_adapters/HiFiAdapterFilt
export PATH=$PATH:/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/hi-fi_adapters/HiFiAdapterFilt/DB

bash pbadapterfilt.sh -t 32 -o pb_adapter_filt/

