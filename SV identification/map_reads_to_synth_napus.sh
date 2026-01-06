#!/bin/bash
#SBATCH --job-name="minimap"
#SBATCH -c 14                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 80G                                # memory pool for all cores
#SBATCH -t 1-10:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/insiliconapus/insilicoslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/insiliconapus/insilicoslurm-%j.err


source package 222eac79-310f-4d4b-8e1c-0cece4150333
source package aeee87c4-1923-4732-aca2-f2aff23580cc

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/

#Index the reference
minimap2 -d /jic/scratch/groups/Richard-Morris/glombikm/references/new_insilico_napus.fa.mmi /jic/scratch/groups/Richard-Morris/glombikm/references/new_insilico_napus.fa

#map reads to the synthetic reference
minimap2 -x map-hifi -t 14 -a /jic/scratch/groups/Richard-Morris/glombikm/references/new_insilico_napus.fa.mmi /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/m84049_240319_214729_s1.hifi_reads.bc2016.fastq > /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/insiliconapus/out_newinsilico_bnapus.sam


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/insiliconapus/


samtools view -@ 8 -bo out_newinsilico_bnapus.bam out_newinsilico_bnapus.sam
samtools sort -o out_newinsilico_bnapus.bam out_newinsilico_bnapus.bam
samtools index out_newinsilico_bnapus.bam
samtools depth out_newinsilico_bnapus.bam > depth_out_newinsilico_bnapus
