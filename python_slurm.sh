#!/bin/bash
#SBATCH --job-name="pythontest"
#SBATCH --output="pythontest.out"
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive
#SBATCH --export=ALL
#SBATCH -t 1:00:00

cd $SLURM_SUBMIT_DIR
python3 helloworld.py