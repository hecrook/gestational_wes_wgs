#!/bin/bash

module load anaconda/3
source activate bcftools

cd /data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/genomes

echo "Working with file: " $1
chr=$(echo $1 | grep -P '(chr[^\.]*)' -o)
output="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/genomes/allele_frequencies_0.001/gnomad.genomes.v4.1.sites.${chr}.af0001.bed"
if [ ! -f "$output" ]; then
	echo "pulling query from" $chr
	bcftools query -i'FILTER="PASS" && INFO/AF>0.001 ' -f'%CHROM\t%POS\t%POS\t%REF\t%ALT\t%INFO/AF\n' $1 > $output
else 
	echo "skipping" $1 "file already exists"
fi
