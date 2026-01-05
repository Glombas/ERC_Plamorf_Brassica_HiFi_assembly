#!/bin/bash
#SBATCH --job-name="agat"
#SBATCH -c 1                                    # number of cores per task
#SBATCH -p jic-short
#SBATCH --mem 10G                                # memory pool for all cores
#SBATCH -t 0-03:00                               # time (D-HH:MM)
#SBATCH -o agatslurm-%j.out
#SBATCH -e agatslurm-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/merge_annot/bnapus/

singularity exec /hpc-home/glombik/agat_1.4.2--pl5321hdfd78af_0.sif agat_sp_complement_annotations.pl --ref liftoff/liftoff_ex.gff3 --add braker.gff3 --out merged_ex.gff3

singularity exec /hpc-home/glombik/agat_1.4.2--pl5321hdfd78af_0.sif agat_sp_keep_longest_isoform.pl --gff merged_ex.gff3 -o isofilt_merged_ex.gff3

cd ../brapa/hap1/

singularity exec /hpc-home/glombik/agat_1.4.2--pl5321hdfd78af_0.sif agat_sp_complement_annotations.pl --ref liftoff/liftoff_ex.gff3 --add braker.gff3 --out merged_ex.gff3

singularity exec /hpc-home/glombik/agat_1.4.2--pl5321hdfd78af_0.sif agat_sp_keep_longest_isoform.pl --gff merged_ex.gff3 -o isofilt_merged_ex.gff3

cd ../brapa/hap2/

singularity exec /hpc-home/glombik/agat_1.4.2--pl5321hdfd78af_0.sif agat_sp_complement_annotations.pl --ref liftoff/liftoff_ex.gff3 --add braker.gff3 --out merged_ex.gff3

singularity exec /hpc-home/glombik/agat_1.4.2--pl5321hdfd78af_0.sif agat_sp_keep_longest_isoform.pl --gff merged_ex.gff3 -o isofilt_merged_ex.gff3
