#!/bin/bash

# This is a script to filter variants from a tumour VCF using only the matched patient sample
# provide the name of the samples to be analysed to the script via the command line like so:
# srun bash script <sample1> <sample2> ...

echo "analysing the following samples: " $@
module load bedtools

# change into results directory
cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/variantcalling_sarek

for sampleid in $@ ; do
        echo -e "\nanalysing sample " $sampleid
        tumvcf="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/filter_vcf/t_${sampleid}.hcfiltered2wgs.filtered.vcf"
        germvcf=$(ls m_$sampleid/m_$sampleid.haplotypecaller.filtered.vcf.gz | xargs realpath)
        outputvcf="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy/$sampleid.matfiltered.hcfiltered2wgs.mutect2.filtered.vcf"

        echo -e "\ninput tumour vcf: " $tumvcf "\ninput germline vcf(s): " $germvcf "\noutput to: " $outputvcf
        #bedtools command
        bedtools intersect -header -v -a $tumvcf -b $germvcf > $outputvcf
done
