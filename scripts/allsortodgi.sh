#!/bin/bash
#SBATCH --job-name="odgisort"
#SBATCH -p nbi-short
#SBATCH --mem 5G                                # memory pool for all cores
#SBATCH -c 8
#SBATCH -t 0-01:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus/allsortslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/references/pggb_pangenome_napus/allsortslurm-%j.err

source package 75928454-a593-430e-b341-5f5a609b34ac

for f in *_he/*final.og;
do odgi sort -i $f -t 8 -P -Y -o $f"."sorted.og;
done
