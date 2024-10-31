#!/bin/bash
# This script is for filtering out germline variants from tumour vcfs that have only been germline filtered using the matched patient sample. Germline variants are defined as those which have an AF of more than 0.001% in gnomad v4.1
# specifically genomic variants.
# The samples to be analysed will be input as arguments on the command line
# Tumour VCFs should have been .hcfiltered2
# germfiltered is optional depending on the purpose of the analysis

module load bedtools
# redriect into directory where tumuour VCFs are
cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy

# specify tumour vcf files
for sample in $@; do
	echo "working with sample" $sample
	tumvcf="${sample}.matfiltered.hcfiltered2.mutect2.filtered.vcf"
	genomesgnomad="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/genomes/allele_frequencies_0.001/all_gnomad_genomes.v4.1.af0001.bed"
	output="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/gnomad_filterVCF/$sample.gnomad.genomes.af0001.matfiltered.hcfiltered2.filtered.vcf"
	# main command 
	bedtools intersect -header -v -a $tumvcf -b $genomesgnomad > $output
done
