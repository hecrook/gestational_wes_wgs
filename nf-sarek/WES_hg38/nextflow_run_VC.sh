#!/bin/bash
#SBATCH --job-name=run_nf-core_WES
#SBATCH --partition=master-worker
#SBATCH --ntasks=1
#SBATCH --time=50:00:00
#SBATCH --mem-per-cpu=4021
#SBATCH --mail-user=hannah.crook@icr.ac.uk
#SBATCH --mail-type=ALL

cd /data/scratch/DMP/UCEC/EVOLIMMU/hcrook/gestational_WES_WGS/nf-sarek/WES_hg38
srun nextflow run nf-core/sarek --input results/csv/recalibrated.csv --step variant_calling --outdir results/ --genome GATK.GRCh38 -profile singularity --wes --tools strelka,mutect2,freebayes -c ICR.config