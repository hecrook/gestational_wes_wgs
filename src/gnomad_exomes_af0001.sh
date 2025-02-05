#!/bin/bash

module load anaconda/3
source activate bcftools

cd /data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/exomes
files=$(ls *.bgz)

for i in $files; do
	echo "Working with file: " $i
	chr=$(echo $i | grep -P '(chr[^\.]*)' -o)
	output="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/exomes/allele_frequencies_0.001/gnomad.exomes.v4.1.sites.${chr}.af0001.bed"
	echo "pulling query from" $chr
	bcftools query -i'FILTER="PASS" && INFO/AF>0.001 ' -f'%CHROM\t%POS\t%POS\t%REF\t%ALT\t%INFO/AF\n' $i > $output
done