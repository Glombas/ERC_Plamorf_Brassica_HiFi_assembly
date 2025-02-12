#!/bin/bash
#SBATCH --job-name="viz"
#SBATCH -p nbi-medium
#SBATCH --mem 10G                                # memory pool for all cores
#SBATCH -t 0-04:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus/allvizsortedslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus/allvizsortedslurm-%j.err

source package 75928454-a593-430e-b341-5f5a609b34ac

for f in *_he/*sorted.og; do odgi viz -i $f -o $f"."_linear_out_sorted.png -x 1000 -d -u; done
