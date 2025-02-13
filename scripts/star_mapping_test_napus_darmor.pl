#!/usr/bin/perl -w

#Aim of this script is to run map contigs from a primary assembly to multiple reference genomes.

my $refnapus='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/rt_anchor_napus_darmor/ragtag.scaffold.fasta';
my $refrapa='/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/anchored_brapa.fa';
my $refdirrapa='/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/star_index_rapa/';
my $refdirnapus='/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/star_index_napus/';

my $output_dir = '/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/mapping_test/';

my $list_of_samples = '/jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/mapping_test/napusbulklist.txt';

chdir("$output_dir") or die "couldn't move to input directory";

open (INPUT_FILE, "$list_of_samples") || die "couldn't open the input file $list_of_samples!";
		    while (my $line = <INPUT_FILE>) {
			chomp $line;
my @array = split(/\t/,$line);
my $sample = $array[0];
my $read1 = $array[1];
my $read2 = $array[2];

my $SLURM_header = <<"SLURM";
#!/bin/bash
#
# SLURM batch script to launch parallel minimap tasks
#
#SBATCH --job-name="star_mapping"
#SBATCH -c 8                                    # number of cores per task
#SBATCH -p nbi-medium
#SBATCH --mem 40G                                # memory pool for all cores
#SBATCH -t 0-13:00                               # time (D-HH:MM)
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/mapping_test/slurm/mapslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_rna_and_single_cell_data/mapping_test/slurm/mapslurm-%j.err


SLURM

 my $tmp_file = "$output_dir/tmp/star.$sample";


  open (SLURM, ">$tmp_file") or die "Couldn't open temp file\n";
  $SLURM_header = $SLURM_header;
  print SLURM "$SLURM_header\n\n";
  print SLURM "\ncd $output_dir\n";


  print SLURM "set -e\n";

	print SLURM "source package 266730e5-6b24-4438-aecb-ab95f1940339\n";
  print SLURM "source package aeee87c4-1923-4732-aca2-f2aff23580cc\n";

	print SLURM "STAR --runThreadN 8 --genomeDir $refdirnapus --readFilesCommand zcat --readFilesIn $read1 $read2 --outFileNamePrefix $output_dir/$sample --outSAMtype BAM SortedByCoordinate\n";
 
	close SLURM;
  system("sbatch $tmp_file");
 # unlink $tmp_file;

}

	    close(INPUT_FILE);
