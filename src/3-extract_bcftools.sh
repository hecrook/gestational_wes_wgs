#!/bin/bash

# script to extract the following columns from VCF files.

# activate conda environment of tools used
module load anaconda/3
source activate bcftools

cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy

vcf=$(ls *.germfiltered.hcfiltered.mutect2.filtered.vcf)
echo "analysing the following files: " $vcf

# extract the chromsome, position, reference allele, alt allele, and allele depth from the filtered VCF  
for i in $vcf; do
	sampleid=$(echo $i | grep -P '^[^.]*' -o)
	output="$sampleid.bcftoolsquery.germfiltered.hcfiltered.mutect2.filtered.txt"
	echo -e "analysing" $sampleid "...\nInput specified:" $i "\nOutput stored in: " $output "\n\n"

	bcftools query -H -f '%CHROM %POS %REF %ALT %DP [%AD %AF]' $i > $output
done
