#!/bin/bash
#SBATCH --job-name=1_filter_VCF
#SBATCH --partition=smp
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=1000
#SBATCH --mail-user=hannah.crook@icr.ac.uk
#SBATCH --mail-type=ALL

################################################################
###### 			 STEP 1. 			########
######  run tumour VCFs through filter_mutect2_HC.py    ########
################################################################

# script to run all desired tumour VCFS (after filtermutect2calls) through the silter_mutec2_HC.py script which filters each varian based on quality and depth. 
# see the script in /bin for more details.  
# submit straight to slurm by wrapping script in sbatch 

# change into results directory 
cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/results/variantcalling_sarek

tumour_dirs=$( find "$PWD" -type d -name 't_*' )
echo "running analysis on " $tumour_dirs

# for loop to run all tumour files through python script
for dir in $tumour_dirs ; do
	echo "changing into directory" $dir
	cd $dir
	gzfile=$(realpath *.mutect2.filtered.vcf.gz)
	gunzip -v $gzfile
	file=$(realpath *.mutect2.filtered.vcf)
	name=$(echo $file | xargs basename | grep -P '^[^.]*' -o)
	output=$(realpath ../../filterVCF/tidy/$name.hcfiltered.filtered.vcf)
	echo "Running sample " $name ", VCF file (" $file ") through python script to filter VCF. Output will be published in " $output
	python3 ../../../bin/filter_mutect2_HC.py $file $output
done

