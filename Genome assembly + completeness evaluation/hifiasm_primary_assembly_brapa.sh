#!/bin/bash
#SBATCH --job-name="hifiasm"
#SBATCH -c 30                                    # number of cores per task
#SBATCH -p nbi-medium
#SBATCH --mem 200G                                # memory pool for all cores
#SBATCH -t 1-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/slurm-%j.err


source package 3c087633-18b1-4e77-9b08-7e68657fce66


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq

hifiasm -o hifiasm/Brapa_primary_assembly -t 30 --hom-cov 50 /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/m84049_240319_214729_s1.hifi_reads.bc2005.fastq 2> ./hifiasm/Brapa_primary_assembly.log

cd hifiasm/

## convert gfa to fa file
awk '/^S/{print ">"$2;print $3}' ./Brapa_primary_assembly.bp.hap1.p_ctg.gfa > ./homcovBrapa_primary_assembly.bp.hap1.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' ./Brapa_primary_assembly.bp.hap2.p_ctg.gfa > ./homcovBrapa_primary_assembly.bp.hap2.p_ctg.fa

## convert unwrapped fasta to wrapped fasta. This is trivial but juicer/3d-dna is written in Java and takes forever to run if this step isn't done
awk -f /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/scripts/wrap-fasta-sequence.awk ./Brapa_primary_assembly.bp.hap1.p_ctg.fa > ./homcovBrapa_primary_assembly.bp.hap1.p_ctg_wrapped.fa
awk -f /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/scripts/wrap-fasta-sequence.awk ./Brapa_primary_assembly.bp.hap2.p_ctg.fa > ./homcovBrapa_primary_assembly.bp.hap2.p_ctg_wrapped.fa
