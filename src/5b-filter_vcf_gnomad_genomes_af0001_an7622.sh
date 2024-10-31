#!/bin/bash
# This script is for filtering out germline variants from a tumour vcf which have an AF of more than 0.001% and an allele number (AN) of greater than 7622 in gnomad v4.1
# specifically genomic variants.
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
genomesgnomad="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/genomes/allele_frequencies_0.001_an7622/all_gnomad_genomes.v4.1.af0001.an7622.bed"
output="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/gnomad_filterVCF/$1.gnomad.genomes.af0001.an7622.hcfiltered.filtered.vcf"
# main command 
bedtools intersect -header -v -a $tumvcf -b $genomesgnomad > $output
