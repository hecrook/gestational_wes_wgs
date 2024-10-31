#!/bin/bash

# script for analysis 3 gnomad filtering (gestational project)
# Input files at this time should be germ filtered with the matched patient germline 

module load bedtools

cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy

exomesgnomad="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/exomes/allele_frequencies_0.001/all_gnomad_exomes.v4.1.af0001.bed"

genomesgnomad="/data/rds/DMP/UCEC/EVOLIMMU/reference_data/broad_institute/gnomad/v4.1/variants/genomes/allele_frequencies_0.001/all_gnomad_genomes.v4.1.af0001.bed"

s21='S21.germfiltered.hcfiltered.mutect2.filtered.vcf'
s6='S6.germfiltered.hcfiltered.mutect2.filtered.vcf'

# S21
echo "analysing sample S21 with input file" $s21
s21_output="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/gnomad_filterVCF/S21.gnomad.exomes.af0001.germfiltered.hcfiltered.mutect2.filtered.vcf"

bedtools intersect -header -v -a $s21 -b $exomesgnomad > $s21_output

echo "finished analysing S21, output saved in " $s21_output

# S6
echo "analysing sample S6 with input file" $s6
s6_output="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/gnomad_filterVCF/S6.gnomad.genomes.af0001.germfiltered.hcfiltered.mutect2.filtered.vcf"

bedtools intersect -header -v -a $s6 -b $genomesgnomad > $s6_output

echo "finished analysing S6, output saved in " $s6_output
