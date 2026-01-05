#!/bin/bash
#SBATCH --job-name="hifiasm"
#SBATCH -c 30                                    # number of cores per task
#SBATCH -p nbi-medium
#SBATCH --mem 200G                                # memory pool for all cores
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/slurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/slurm-%j.err

echo "Started:"
date

source package 3c087633-18b1-4e77-9b08-7e68657fce66


cd /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq

hifiasm -o hifiasm/Bnapus_primary_assembly -t 30 --hom-cov 59 /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/m84049_240319_214729_s1.hifi_reads.bc2016.fastq 2> ./hifiasm/Bnapus_primary_assembly.log

cd hifiasm/

## convert gfa to fa file
awk '/^S/{print ">"$2;print $3}' ./homcovBnapus_primary_assembly.bp.p_ctg.gfa > ./homcovBnapus_primary_assembly.bp.p_ctg.fa

## convert unwrapped fasta to wrapped fasta. This is trivial but juicer/3d-dna is written in Java and takes forever to run if this step isn't done
awk -f /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/scripts/wrap-fasta-sequence.awk ./Bnapus_primary_assembly.bp.p_ctg.fa > ./Bnapus_primary_assembly.bp.p_ctg_wrapped.fa

echo "Finished:"
date
