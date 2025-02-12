#!/bin/bash
#SBATCH --job-name="extract_cp_mt_contigs"
#SBATCH -c 1                                    # number of cores per task
#SBATCH -p jic-short
#SBATCH --mem 4G                                # memory pool for all cores
#SBATCH -t 0-00:50                               # time (D-HH:MM)
#SBATCH --ntasks-per-node=1
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/slurmextract.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/slurmextract.err



source package 1413a4f0-44e3-4b9d-b6c6-0f5c0048df88

cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/

species=('Brapa' 'Bnapus')

for spec in ${species[@]};
do 
# First mt contigs
grep 'NC_049892.1' log_brapa_organelle | awk '{print $2}' > Brapa_mt_contig_list.txt;
grep 'NC_008285.1' log_bnapus_organelle | awk '{print $2}' > Bnapus_mt_contig_list.txt;
# Now cp contigs
grep 'NC_040849.1' log_brapa_organelle | awk '{print $2}' > Brapa_cp_contig_list.txt;
grep 'NC_016734.1' log_bnapus_organelle | awk '{print $2}' > Bnapus_cp_contig_list.txt;


# Now run python script that will extract these contigs from the wrapped assembly
python3 ../../../../scripts/extract_fasta_seqs.py -i ../${spec}_primary_assembly.bp.p_ctg_wrapped.fa -o ${spec}_mt_contigs_extracted.fa -c ${spec}_mt_contig_list.txt;
python3 ../../../../scripts/extract_fasta_seqs.py -i ../${spec}_primary_assembly.bp.p_ctg_wrapped.fa -o ${spec}_cp_contigs_extracted.fa -c ${spec}_cp_contig_list.txt;

done