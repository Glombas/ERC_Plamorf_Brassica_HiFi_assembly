#!/usr/bin/perl -w

#Aim of this script is to run map contigs from a primary assembly to multiple reference genomes.


my $output_dir = '/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/minimap/';
my $assembly_path = '/jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/homcovBnapus_primary_assembly.no_organelles.fa';
my $ref_path = '/jic/scratch/groups/Richard-Morris/glombikm/references/';
my $species = 'homcovBnapus_no_org_map_';

my $list_of_refs = '/jic/scratch/groups/Richard-Morris/glombikm/references/bnapus-list.txt';

chdir("$ref_path") or die "couldn't move to input directory";

open (INPUT_FILE, "$list_of_refs") || die "couldn't open the input file $list_of_refs!";
		    while (my $line = <INPUT_FILE>) {
			chomp $line;
my @array = split(/\t/,$line);
my $sample = $array[0];
my $reference = $array[1];

my $SLURM_header = <<"SLURM";
#!/bin/bash
#
# SLURM batch script to launch parallel minimap tasks
#
#SBATCH --job-name="minimap"
#SBATCH -c 24                                    # number of cores per task
#SBATCH -p nbi-medium
#SBATCH --mem 100G                                # memory pool for all cores
#SBATCH -t 2-00:00                               # time (D-HH:MM)
#SBATCH -o /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/minimapslurm-%j.out
#SBATCH -e /jic/scratch/groups/Richard-Morris/glombikm/brassica_hifi_data/bamfiles/fastq/hifiasm/organelle_filter/minimapslurm-%j.err


SLURM

 my $tmp_file = "$output_dir/tmp/minimap.$sample";


  open (SLURM, ">$tmp_file") or die "Couldn't open temp file\n";
  $SLURM_header = $SLURM_header;
  print SLURM "$SLURM_header\n\n";
  print SLURM "\ncd $ref_path\n";


  print SLURM "set -e\n";

	print SLURM "source package 222eac79-310f-4d4b-8e1c-0cece4150333\n";
	print SLURM "minimap2 -x map-hifi -t 24 -c $reference $assembly_path > $output_dir/$species-$sample".".paf\n";

	close SLURM;
  system("sbatch $tmp_file");
 # unlink $tmp_file;

}

	    close(INPUT_FILE);
