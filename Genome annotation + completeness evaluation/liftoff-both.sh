#!/bin/bash
#SBATCH --job-name="liftoff"
#SBATCH -c 1                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 80G                                # memory pool for all cores
#SBATCH -t 1-03:00                               # time (D-HH:MM)
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk

export PATH=/hpc-home/glombik/mamba/envs/liftoff/bin/:$PATH

ref_location=/jic/scratch/groups/Richard-Morris/glombikm/references/

#b.napus
my_assembly=/jic/scratch/groups/Richard-Morris/glombikm/assemblies_storage/bnapus/full_ragtag.scaffold.fasta.masked
liftoff -infer_genes -f feature.txt -g $ref_location/BnapusDarmor-bzh_annotation.gff -o liftoff.gff3 -u unmapped_liftoff.txt $my_assembly $ref_location/BnapusDarmor-bzh_chromosomes.fasta
#b.rapa
my_assembly=/jic/scratch/groups/Richard-Morris/glombikm/assemblies_storage/brapa/hap1/full_ragtag.scaffold.fasta.masked
liftoff -infer_genes -f feature.txt -g $ref_location/Brapa_chiifu_v41_genome20230413.gff -o liftoff.gff3 -u unmapped_liftoff.txt $my_assembly $ref_location/Brapa_chiifu_v41_genome20230413.fasta
my_assembly=/jic/scratch/groups/Richard-Morris/glombikm/assemblies_storage/brapa/hap2/full_ragtag.scaffold.fasta.masked
liftoff -infer_genes -f feature.txt -g $ref_location/Brapa_chiifu_v41_genome20230413.gff -o liftoff.gff3 -u unmapped_liftoff.txt $my_assembly $ref_location/Brapa_chiifu_v41_genome20230413.fasta


