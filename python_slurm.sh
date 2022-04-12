#!/bin/bash
#SBATCH --job-name="pythontest"
#SBATCH --output=pythontest.%A_%a.out
#SBATCH --arra=1-3
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive
#SBATCH --export=ALL
#SBATCH -t 1:00:00

cd $SLURM_SUBMIT_DIR
module load gnu9/9.3.0
python3 helloworld.py
