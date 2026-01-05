#!/bin/bash
#SBATCH --job-name="organelle_filter"
#SBATCH -p nbi-medium
#SBATCH --mem 50G                                # memory pool for all cores
#SBATCH -c 4
#SBATCH -t 0-03:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/slurm-%j.err


source package d6092385-3a81-49d9-b044-8ffb85d0c446 # blast+ 2.9.0


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/
makeblastdb -in Brapa_primary_assembly.bp.p_ctg_wrapped.fa -dbtype nucl

#blast organelle genomes to assembly
refpath='/jic/scratch/groups/Richard-Morris/glombikm/references'

blastn -query $refpath/b_rapa_cp_genome.fasta -db Brapa_primary_assembly.bp.hap1.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/brapa_hap1_cp_hits.xml
blastn -query $refpath/b_rapa_cp_genome.fasta -db Brapa_primary_assembly.bp.hap2.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/brapa_hap2_cp_hits.xml
blastn -query $refpath/b_rapa_mt_genome.fasta -db Brapa_primary_assembly.bp.hap1.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/brapa_hap1_mt_hits.xml
blastn -query $refpath/b_rapa_mt_genome.fasta -db Brapa_primary_assembly.bp.hap2.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/brapa_hap2_mt_hits.xml

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/
makeblastdb -in Bnapus_primary_assembly.bp.p_ctg_wrapped.fa -dbtype nucl

blastn -query $refpath/b_napus_cp_genome.fasta -db Bnapus_primary_assembly.bp.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/bnapus_cp_hits.xml
blastn -query $refpath/b_napus_mt_genome.fasta -db Bnapus_primary_assembly.bp.p_ctg_wrapped.fa -num_threads 4 -outfmt 5 -out organelle_filter/bnapus_mt_hits.xml



# First mt contigs
grep 'NC_049892.1' log_brapa_hap1_organelle | awk '{print $2}' > Brapa_hap1_mt_contig_list.txt;
grep 'NC_049892.1' log_brapa_hap2_organelle | awk '{print $2}' > Brapa_hap2_mt_contig_list.txt;
grep 'NC_008285.1' log_bnapus_organelle | awk '{print $2}' > Bnapus_mt_contig_list.txt;
# Now cp contigs
grep 'NC_040849.1' log_brapa_hap1_organelle | awk '{print $2}' > Brapa_hap1_cp_contig_list.txt;
grep 'NC_040849.1' log_brapa_hap2_organelle | awk '{print $2}' > Brapa_hap2_cp_contig_list.txt;
grep 'NC_016734.1' log_bnapus_organelle | awk '{print $2}' > Bnapus_cp_contig_list.txt;


cat Brapa_hap1_mt_contig_list.txt Brapa_hap1_cp_contig_list.txt > Brapa_hap1_org_contig_list.txt
cat Brapa_hap2_mt_contig_list.txt Brapa_hap2_cp_contig_list.txt > Brapa_hap2_org_contig_list.txt
cat Bnapus_mt_contig_list.txt Bnapus_cp_contig_list.txt > Bnapus_org_contig_list.txt

# Now run python script that will extract these contigs from the wrapped assembly
python3 ../../../../scripts/extract_minus_fasta_seqs.py -i ../Brapa_primary_assembly.bp.hap1.p_ctg_wrapped.fa -o Brapa_hap1_org_contigs_extracted.fa -c Brapa_hap1_org_contig_list.txt;
python3 ../../../../scripts/extract_minus_fasta_seqs.py -i ../Brapa_primary_assembly.bp.hap2.p_ctg_wrapped.fa -o Brapa_hap2_org_contigs_extracted.fa -c Brapa_hap2_org_contig_list.txt;
python3 ../../../../scripts/extract_minus_fasta_seqs.py -i ../Bnapus_primary_assembly.bp.p_ctg_wrapped.fa -o Bnapus_org_contigs_extracted.fa -c Bnapus_org_contig_list.txt;
