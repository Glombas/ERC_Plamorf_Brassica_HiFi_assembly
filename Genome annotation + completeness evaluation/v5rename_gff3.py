import re

# Keep track of gene numbering and chromosome
gene_number = 20
current_chrom = ""
current_gene_id = ""

with open("isofilt_merged.gff3") as infile, open("renamed_v5.gff3", "w") as outfile:
    for line in infile:
        if line.startswith("#") or not line.strip():
            outfile.write(line)
            continue

        fields = line.strip().split("\t")
        attributes = fields[8]
        chrom = fields[0].replace("_RagTag", "")  # adjust if needed

        # Check if we’ve moved to a new chromosome and reset the gene counter
        if chrom != current_chrom:
            current_chrom = chrom
            gene_number = 20

        if fields[2] == "gene":
            # Assign new gene ID
            gene_id = f"Bna.FP.v1.{chrom}.g{gene_number:06d}"
            current_gene_id = gene_id  # store for mRNA and subfeatures
            gene_number += 20

            # Replace ID and Name
            attributes = re.sub(r'ID=[^;]+', f'ID={gene_id}', attributes)
            attributes = re.sub(r'Name=[^;]+', f'Name={gene_id}', attributes)

        elif fields[2] in ["mRNA", "transcript"]:
            # Assign transcript ID based on current gene
            transcript_id = current_gene_id + ".1"
            attributes = re.sub(r'ID=[^;]+', f'ID={transcript_id}', attributes)
            attributes = re.sub(r'Parent=[^;]+', f'Parent={current_gene_id}', attributes)
            attributes = re.sub(r'Name=[^;]+', f'Name={transcript_id}', attributes)

        elif fields[2] in ["exon", "CDS", "start_codon", "stop_codon", "intron","five_prime_UTR","three_prime_UTR","UTR"]:
            match = re.search(r'Parent=([^;]+)', attributes)
            if match:
                parent = match.group(1)
                subfeature_type = fields[2]
                subfeature_index = re.search(r'(\d+)', attributes)
                number = subfeature_index.group(1) if subfeature_index else "1"
                sub_id = f"{current_gene_id}.1.{subfeature_type}{number if subfeature_type != 'exon' else '1'}"
                attributes = re.sub(r'ID=[^;]+', f'ID={sub_id}', attributes)
                attributes = re.sub(r'Parent=[^;]+', f'Parent={current_gene_id}.1', attributes)

        fields[8] = attributes
        outfile.write("\t".join(fields) + "\n")
