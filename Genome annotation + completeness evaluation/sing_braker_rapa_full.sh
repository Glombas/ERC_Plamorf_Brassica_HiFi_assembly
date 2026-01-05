#!/bin/bash
#SBATCH --job-name="braker"
#SBATCH -c 20                                    # number of cores per task
#SBATCH -p jic-medium
#SBATCH --mem 170G                                # memory pool for all cores
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/braker_annot/rapa_full/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/braker_annot/rapa_full/slurm-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk



source package /nbi/software/testing/bin/genemark-4.33_ES_ET

source package f9c1e0c5-d0e8-4ba0-9edd-88235400fa13 #hisat 2.1.0

source package /nbi/software/testing/bin/cdbfasta-20130423 #cdbtools


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/braker_annot/brapa_haps_separate/hap1/

singularity exec /hpc-home/glombik/braker3.sif braker.pl --species=Brassicarapa_hap1FP_full_nolow --AUGUSTUS_ab_initio --gff3 --threads 20 --workingdir=wd_sing --genome=full_ragtag.scaffold.fasta.masked --rnaseq_sets_ids=HOMO_R1,HOMO_R2,HOMO_R3 --rnaseq_sets_dirs=/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/X204SC22115099-Z01-F001/01.RawData/all_homo_braker/

cd ../hap2/

singularity exec /hpc-home/glombik/braker3.sif braker.pl --species=Brassicarapa_hap2FP_full_nolow --AUGUSTUS_ab_initio --gff3 --threads 20 --workingdir=wd_sing --genome=full_ragtag.scaffold.fasta.masked --rnaseq_sets_ids=HOMO_R1,HOMO_R2,HOMO_R3 --rnaseq_sets_dirs=/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/X204SC22115099-Z01-F001/01.RawData/all_homo_braker/
