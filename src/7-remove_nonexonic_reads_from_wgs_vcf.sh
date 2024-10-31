#!/bin/bash

# script for removing variants in the WGS VCFs that are outside the WES coverage area 
# using the padded bed file uded for the WES sequencing for intersection

module load bedtools

# define the exomes bed file
wesbed="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/data/sequencingInfo/wes/agilent_sureselect_v6/S07604514_Padded.bed"

# define input samples files S6 and S17
s17="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy/S17.germfiltered.hcfiltered.mutect2.filtered.vcf"
s6="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/gnomad_filterVCF/S6.gnomad.genomes.af0001.germfiltered.hcfiltered.mutect2.filtered.vcf"

# define outputs
s17_output="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/exonic_wgs_VCF/S17_exonic.germfiltered.hcfiltered.mutect2.filtered.vcf"
s6_output="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/exonic_wgs_VCF/S6_exonic.gnomad.genomes.af0001.germfiltered.hcfiltered.mutect2.filtered.vcf"

# s17
echo "analysing sample S17 with input file:" $s17
bedtools intersect -header -a $s17 -b $wesbed > $s17_output
echo "finished analysing sample S17, output saved in:" $s17_output
# s6
echo -e "\nanalysing sample S6 with input file:" $s6
bedtools intersect -header -a $s6 -b $wesbed > $s6_output
echo "finished analysing sample S6, output saved in:" $s6_output

