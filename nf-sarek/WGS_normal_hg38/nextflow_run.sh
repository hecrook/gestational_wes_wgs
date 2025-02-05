#!/bin/bash
#SBATCH --job-name=run_sarekWGS
#SBATCH --partition=master-worker
#SBATCH --ntasks=1
#SBATCH --time=50:00:00
#SBATCH --mem-per-cpu=4021
#SBATCH --mail-user=hannah.crook@icr.ac.uk
#SBATCH --mail-type=ALL

srun nextflow run nf-core/sarek --input samplesheet.csv --outdir results/ --genome GATK.GRCh38 -profile singularity -c ICR.config -r 3.4.0 --tools haplotypecaller -resume
