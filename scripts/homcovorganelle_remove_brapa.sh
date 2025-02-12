#!/bin/bash
#SBATCH --job-name="organelle_filter"
#SBATCH -p nbi-medium
#SBATCH --mem 30G                                # memory pool for all cores
#SBATCH -c 4
#SBATCH -t 0-01:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/slurm-%j.err


source package d6092385-3a81-49d9-b044-8ffb85d0c446 # blast+ 2.9.0


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/
makeblastdb -in homcovBrapa_primary_assembly.bp.p_ctg_wrapped.fa -dbtype nucl

#blast organelle genomes to assembly
refpath='/jic/scratch/groups/Richard-Morris/glombikm/references'

blastn -query $refpath/b_rapa_cp_genome.fasta -db homcovBrapa_primary_assembly.bp.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/homcovbrapa_cp_hits.xml
blastn -query $refpath/b_rapa_mt_genome.fasta -db homcovBrapa_primary_assembly.bp.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/homcovbrapa_mt_hits.xml

source  jre-1.8.0_45

java -jar /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/programs/FilterOrganelles.jar -i homcovBrapa_primary_assembly.bp.p_ctg_wrapped.fa -c organelle_filter/homcovbrapa_cp_hits.xml -m organelle_filter/homcovbrapa_mt_hits.xml -o organelle_filter/homcovBrapa_primary_assembly.no_organelles.fa > organelle_filter/log_homcovBrapa_primary_assembly_organelle