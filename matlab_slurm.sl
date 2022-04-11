#!/bin/bash -l
#SBATCH --job-name=matlab_test
#SBATCH --output="Matlabtest.out"
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --exclusive
#SBATCH --export=ALL
#SBATCH -t 200:00:00
# Choose a version of MATLAB by loading a module:
module load matlab/R2021a
# Remove -singleCompThread below if you are using parallel commands:
matlab -nodisplay -singleCompThread -r "yalmipquadopt"