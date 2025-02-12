#!/bin/bash
#SBATCH --job-name="pangenome"
#SBATCH -c 30                                    # number of cores per task
#SBATCH -p nbi-medium
#SBATCH --mem 40G                                # memory pool for all cores
#SBATCH -t 0-03:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus/a02c02_he/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus/a02c02_he/slurm-%j.err


source package 2841c8d7-8a3a-43ef-82d2-fdffd782fb89

cd /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus

#due to incompatibility of singularity container with Alma Linux 9 (HPC OS)
unset -f which

#now run the pangenome graph assembly
pggb -i prefixed_a2c2_extracted.fasta -o a02c02_he -n 7 -t 30 -p 90 -s 10000 -V darmor -S -m 

