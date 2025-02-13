#!/bin/bash
#SBATCH --job-name="starindex"
#SBATCH -p nbi-short
#SBATCH -c 6
#SBATCH --mem 30G                                # memory pool for all cores
#SBATCH -t 0-02:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/mapping_test/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/mapping_test/slurm-%j.err

#refnapusdarmor='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/rt_anchor_napus_darmor/ragtag.scaffold.fasta'
#refnapusdaae='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/rt_anchor_napus_daae/ragtag.scaffold.fasta'
#refrapa='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/rt_anchor_rapa_chiifu/ragtag.scaffold.fasta'
#refdirrapa='/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/star_index_rapa/'
#refdirnapusdarmor='/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/star_index_napus/'
#refdirnapusdaae='/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/star_index_napusdaae/'
refpubdarmor='/jic/scratch/groups/Richard-Morris/glombikm/references/BnapusDarmor-bzh_chromosomes.fasta'
refdirpubdarmor='/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/star_index_pubdarmor/'

source package 266730e5-6b24-4438-aecb-ab95f1940339 #star 2.7.0a

#STAR --runMode genomeGenerate --runThreadN 6 --genomeSAindexNbases 13 --genomeDir $refdirnapus --genomeFastaFiles $refnapus
#STAR --runMode genomeGenerate --runThreadN 6 --genomeSAindexNbases 13 --genomeDir $refdirnapusdaae --genomeFastaFiles $refnapusdaae
#STAR --runMode genomeGenerate --runThreadN 6 --genomeSAindexNbases 13 --genomeDir $refdirrapa --genomeFastaFiles $refrapa
STAR --runMode genomeGenerate --runThreadN 6 --genomeSAindexNbases 13 --genomeDir $refdirpubdarmor --genomeFastaFiles $refpubdarmor
