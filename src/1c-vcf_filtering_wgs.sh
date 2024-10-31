#!/bin/bash
#SBATCH --job-name=1_filter_VCF
#SBATCH --partition=smp
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=1000
#SBATCH --mail-user=hannah.crook@icr.ac.uk
#SBATCH --mail-type=ALL

# script to run tumour samples through the filter_mutect2_HC2_wgs.py script in /bin

# change into results directory 
cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/variantcalling_sarek

# find wgs samples specifically
tumour_dirs=$( find $PWD -type d \( -name "t_S6" -o -name "t_S17" \) )
echo "running analysis on " $tumour_dirs

# for loop to run all tumour files through python script
for dir in $tumour_dirs ; do
	echo "changing into directory" $dir
	cd $dir
	file=$(realpath *.mutect2.filtered.vcf)
	name=$(echo $file | xargs basename | grep -P '^[^.]*' -o)
	output="/data/rds/DMP/UCEC/EVOLIMMU/hcrook/temp_results/filter_vcf/$name.hcfiltered2wgs.filtered.vcf"
	echo "Running sample " $name ", VCF file (" $file ") through python script to filter VCF. Output will be published in " $output
	python3 ../../../bin/filter_mutect2_HC2_WGS.py $file $output
done

