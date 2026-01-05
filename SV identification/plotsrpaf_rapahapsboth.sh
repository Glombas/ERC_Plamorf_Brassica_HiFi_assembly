#!/bin/bash
#SBATCH --job-name="plotsr"
#SBATCH -c 60                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 300G                                # memory pool for all cores
#SBATCH -t 0-06:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o plotsrslurm-%j.out
#SBATCH -e plotsrslurm-%j.err


source package 222eac79-310f-4d4b-8e1c-0cece4150333 #minimap2
source package aeee87c4-1923-4732-aca2-f2aff23580cc #samtools

export PATH=/hpc-home/glombik/mamba/envs/plotsr/bin/:$PATH

#cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/insiliconapus/
#Index the reference
#minimap2 -d syri_brapa_chiifu.fa.mmi syri_brapa_chiifu.fa
#minimap2 -d syri_brapa_hap1_fp.fa.mmi syri_brapa_hap1_fp.fa
#minimap2 -d syri_new_insilico_napus.fa.mmi syri_new_insilico_napus.fa


minimap2 -x asm5 -t 60 -c --eqx syri_brapa_hap1_fp.fa.mmi \
syri_brapa_chiifu.fa > A_Brapahap1ch.paf

minimap2 -x asm5 -t 60 -c --eqx syri_brapa_chiifu.fa.mmi \
syri_brapa_hap2_fp.fa > B_Crapahap2ch.paf


syri -c A_Brapahap1ch.paf -r syri_brapa_hap1_fp.fa \
--nc 14 --nosnp -q syri_brapa_chiifu.fa -F P --prefix A_Brapahap1chpaf

syri -c B_Crapahap2ch.paf -r syri_brapa_chiifu.fa \
--nc 14 --nosnp -q syri_brapa_hap2_fp.fa -F P --prefix B_Crapahap2chpaf

awk '{if (($11=="DEL"||"DUP"||"DUPAL"||"INS"||"INV"||"INVAL"||"INVDP"||"INVDPAL"||"INVTR"||"INVTRAL"||"TRANS"||"TRANSAL") && (($3-$2)<=1000)) {next} else {print $0}}' A_Brapahap1chpafsyri.out > lSVfilr_A_Brapahap1chpafsyri.out
awk '{if (($11=="DEL"||"DUP"||"DUPAL"||"INS"||"INV"||"INVAL"||"INVDP"||"INVDPAL"||"INVTR"||"INVTRAL"||"TRANS"||"TRANSAL") && (($3-$2)<=1000)) {next} else {print $0}}' B_Crapahap2chpafsyri.out > lSVfilr_B_Crapahap2chpafsyri.out

plotsr \
    --sr lSVfilr_A_Brapahap1chpafsyri.out \
    --sr lSVfilr_B_Crapahap2chpafsyri.out \
    --genomes rapahapbothgenomes.txt \
    -o lSVfilr_rapahapboth_output_plot.png
