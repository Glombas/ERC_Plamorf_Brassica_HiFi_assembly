#!/bin/bash
#SBATCH --job-name="jellyfish"
#SBATCH -c 4                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 200G                                # memory pool for all cores
#SBATCH -t 1-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/jfslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/jfslurm-%j.err


source package 3fe68588-ae0b-4935-b029-7a2dfbf1c4f3

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq

for f in m84049*bc*fastq; do jellyfish count -C -m 21 -s 20000000000 -t 4 $f -o $f.jf; 
jellyfish histo -t 8 $f.jf > histo_$f;
done

