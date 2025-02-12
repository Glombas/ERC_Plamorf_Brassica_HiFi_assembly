#!/bin/bash
#SBATCH --job-name="ragtag_test"
#SBATCH -p nbi-medium
#SBATCH --mem 80G                                # memory pool for all cores
#SBATCH -c 10
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/ragtagslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/ragtagslurm-%j.err


#load in conda env

export PATH=/hpc-home/glombik/mamba/envs/ragtagenv/bin/:$PATH

refs='/jic/scratch/groups/Richard-Morris/glombikm/references'
anchors='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring'
assembly='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter'

cd $anchors

ragtag.py scaffold -t 10 -o rt_anchor_rapa_chiifu $refs/Brapa_chiifu_v41_genome20230413.fasta $assembly/homcovBrapa_primary_assembly.no_organelles.fa
ragtag.py scaffold -t 10 -o rt_anchor_rapa_z1 $refs/BrapaZ1_v2_chromosomes.fasta $assembly/homcovBrapa_primary_assembly.no_organelles.fa

#merge the two
ragtag.py merge -o merger_rt_anchor_rapa $assembly/homcovBrapa_primary_assembly.no_organelles.fa rt_anchor_rapa_z1/*agp rt_anchor_rapa_chiifu/*agp
