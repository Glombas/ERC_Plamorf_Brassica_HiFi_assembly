#!/bin/bash
#SBATCH --job-name="plotsr"
#SBATCH -c 60                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 300G                                # memory pool for all cores
#SBATCH -t 0-14:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o plotsrslurm-%j.out
#SBATCH -e plotsrslurm-%j.err


source package 222eac79-310f-4d4b-8e1c-0cece4150333 #minimap2
source package aeee87c4-1923-4732-aca2-f2aff23580cc #samtools

export PATH=/hpc-home/glombik/mamba/envs/plotsr/bin/:$PATH

#cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/insiliconapus/

#Index the reference
#minimap2 -d syri_bnapus_darmor.fa.mmi syri_bnapus_darmor.fa
#minimap2 -d syri_bnapus_fp.fa.mmi syri_bnapus_fp.fa
#minimap2 -d syri_new_insilico_napus.fa.mmi syri_new_insilico_napus.fa


minimap2 -x asm5 -t 60 -c --eqx syri_new_insilico_napus.fa.mmi \
syri_bnapus_fp.fa > A_B.paf

minimap2 -x asm5 -t 60 -c --eqx syri_bnapus_fp.fa.mmi \
syri_bnapus_darmor.fa > B_C.paf


syri -c A_B.paf -r syri_new_insilico_napus.fa \
--nc 14 --nosnp -q syri_bnapus_fp.fa -F P --prefix A_Bpaf

syri -c B_C.paf -r syri_bnapus_fp.fa \
--nc 14 --nosnp -q syri_bnapus_darmor.fa -F P --prefix B_Cpaf

awk '{if (($11=="DEL"||"DUP"||"DUPAL"||"INS"||"INV"||"INVAL"||"INVDP"||"INVDPAL"||"INVTR"||"INVTRAL"||"TRANS"||"TRANSAL") && (($3-$2)<=1000)) {next} else {print $0}}' A_Bpafsyri.out > lSVfilr_A_Bpafsyri.out
awk '{if (($11=="DEL"||"DUP"||"DUPAL"||"INS"||"INV"||"INVAL"||"INVDP"||"INVDPAL"||"INVTR"||"INVTRAL"||"TRANS"||"TRANSAL") && (($3-$2)<=1000)) {next} else {print $0}}' B_Cpafsyri.out > lSVfilr_B_Cpafsyri.out

plotsr \
    --sr lSVfilr_A_Bpafsyri.out \
    --sr lSVfilr_B_Cpafsyri.out \
    --genomes genomes.txt \
    -o lSVfilr_output_plot.png
