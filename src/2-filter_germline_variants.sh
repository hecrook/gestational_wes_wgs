#!/bin/bash
#SBATCH --job-name=2-germline_filter_VCF
#SBATCH --partition=smp
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=1000
#SBATCH --mail-user=hannah.crook@icr.ac.uk
#SBATCH --mail-type=ALL

# script to remove familial germline variants from the tumour VCF files using VCF from haplotypecaller.
# provide the name of the samples to be analysed to the script via the command line like so:
# srun bash script <sample1> <sample2> ...

echo "analysing the following samples: " $@
module load bedtools

# change into results directory 
cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/variantcalling_sarek

for sampleid in $@ ; do
	echo -e "\nanalysing sample " $sampleid
	tumvcf="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy/t_$sampleid.hcfiltered.filtered.vcf"
	germvcf=$(ls [!t]_$sampleid/[!t]_$sampleid.haplotypecaller.filtered.vcf.gz | xargs realpath)
	outputvcf="/data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/filterVCF/tidy/$sampleid.germfiltered.hcfiltered.mutect2.filtered.vcf"

	echo -e "\ninput tumour vcf: " $tumvcf "\ninput germline vcf(s): " $germvcf "\noutput to: " $outputvcf
	#bedtools command
	bedtools intersect -header -v -a $tumvcf -b $germvcf > $outputvcf
done
