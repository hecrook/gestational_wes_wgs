#!/bin/bash
# This script is for filtering out germline variants from a tumour vcf which have an AF of more than 0.001% and an allele number (AN) of greater than 73095 in gnomad v4.1
# specifically exonic variants.
# The samples to be analysed will be input as arguments on the command line (this can also be done by wrapping in an srun command in another script if you want to make into an array)
# The samples provided as arguments to script should be the names of directories in the filterVCF/tidy directory
# Tumour VCFs should have been .hcfiltered
# germfiltered is optional depending on the purpose of the analysis

module load bedtools
# redriect into directory where tumour VCFs are
cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy

# specify tumour vcf files
echo "working with sample" $1
tumvcf="t_$1.hcfiltered.filtered.vcf"
exomesgnomad="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/exomes/allele_frequencies_0.001_an73095/all_gnomad_exomes.v4.1.af0001.an73095.bed"
output="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/gnomad_filterVCF/$1.gnomad.exomes.af0001.an73095.hcfiltered.filtered.vcf"
# main command 
bedtools intersect -header -v -a $tumvcf -b $exomesgnomad > $output
