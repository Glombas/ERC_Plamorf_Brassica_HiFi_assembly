#!/bin/bash
#SBATCH --job-name="checkcdsend"
#SBATCH -c 1                                    # number of cores per task
#SBATCH -p jic-short
#SBATCH --mem 10G                                # memory pool for all cores
#SBATCH -t 0-01:00                               # time (D-HH:MM)
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marek.glombik@jic.ac.uk

# Input CDS FASTA file
cds_fasta=$1
# Output file for genes that don't start with ATG
output_file=$2

# Make sure the output file is empty before starting
> "$output_file"

# check stop codons
awk '
    BEGIN {seq_name=""; seq=""}
    /^>/ {
        if (seq_name != "" && !(tolower(substr(seq, length(seq)-2, 3)) == "taa" ||
                                tolower(substr(seq, length(seq)-2, 3)) == "tag" ||
                                tolower(substr(seq, length(seq)-2, 3)) == "tga")) {
            print seq_name >> "'$output_file'"
        }
        seq_name = $0
        seq = ""
        next
    }
    {seq = seq $0}
    END {
        if (seq_name != "" && !(tolower(substr(seq, length(seq)-2, 3)) == "taa" ||
                                tolower(substr(seq, length(seq)-2, 3)) == "tag" ||
                                tolower(substr(seq, length(seq)-2, 3)) == "tga")) {
            print seq_name >> "'$output_file'"
        }
    }
' "$cds_fasta"

echo "Check complete. Gene names without a valid stop codon (TAA, TAG, TGA) are saved in $output_file"
