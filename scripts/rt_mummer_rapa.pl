#!/usr/bin/perl -w

#Aim of this script is to run map contigs from a primary assembly to multiple reference genomes.


my $output_dir = '/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/ragtag_mummer';
my $ref_path = '/jic/scratch/groups/Richard-Morris/glombikm/references/';

my $list_of_refs = '/jic/scratch/groups/Richard-Morris/glombikm/references/ragtag_rapa-list.txt';

chdir("$ref_path") or die "couldn't move to input directory";

open (INPUT_FILE, "$list_of_refs") || die "couldn't open the input file $list_of_refs!";
		    while (my $line = <INPUT_FILE>) {
			chomp $line;
my @array = split(/\t/,$line);
my $sample = $array[0];
my $reference = $array[1];
my $assembly = $array[2];

my $SLURM_header = <<"SLURM";
#!/bin/bash
#
# SLURM batch script to launch parallel minimap tasks
#
#SBATCH --job-name="rt_mummer"
#SBATCH -p nbi-medium
#SBATCH --mem 20G                                # memory pool for all cores
#SBATCH -t 0-14:00                               # time (D-HH:MM)
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/ragtag_mummer/ragtagmummerslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/anchoring/ragtag_mummer/ragtagmummerslurm-%j.err


SLURM

 my $tmp_file = "$output_dir/tmp/minimap.$sample";


  open (SLURM, ">$tmp_file") or die "Couldn't open temp file\n";
  $SLURM_header = $SLURM_header;
  print SLURM "$SLURM_header\n\n";
  print SLURM "\ncd $ref_path\n";


  print SLURM "set -e\n";

	print SLURM "source package eab121cb-2eb8-49c1-a9a5-a33754ea9fea\n";

	print SLURM "nucmer -p $output_dir/$sample"."_mummer -l 500 $reference $assembly\n";
	print SLURM "delta-filter -1 -i 90 -l 100 $output_dir/$sample"."_mummer.delta > $output_dir/filtered_"."$sample\n";


	close SLURM;
  system("sbatch $tmp_file");
 # unlink $tmp_file;

}

	    close(INPUT_FILE);
