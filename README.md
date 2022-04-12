# slurm_tutorial

## Github Desktop
To download Github Desktop: https://desktop.github.com/

Login with your credentials and allocate the slurm_tutorial repository. Make a copy to your local machine. (You might not want to set the github folder under a cloud folder.)

## Hopper
Homepage: https://www.cac.cornell.edu/wiki/index.php?title=Hopper_Cluster
You will be able to find all the basic information about Hopper from the homepage. Some of the following information is taken from the homepage.

We are sharing this cluster with several groups, so there is a google doc to help us communicate with each and planning our job submission accordingly:
https://docs.google.com/spreadsheets/d/1eZZJYHK_LbwlbSAHN-icJT7H-2FuSoEnRMCIcPNX2GA/edit#gid=0

### Login node
- There is 1 login nodes and 22 computing nodes on the cluster. The login node is used for submitting jobs or requesting interactive sessions (You should never run computationally heavy job on the login node)
- Use `ssh` to login `ssh yournetid@hopper.cac.cornell.edu`

### Computing nodes
- There are 22 compute nodes (c0001-c0022) with dual 20-core Intel Xeon Gold 5218R CPUs @ 2.1 GHz, 192 GB of RAM
- You can submit job to the compute nodes using `sbatch` or requrest an interactive node using `salloc`. These are command of the `slurm`, which is a cluster management and job scheduling system for large and small Linux clusters. 
- Some resources for slurm:
  - [Slurm introduction by Princeton Research
    Computing](https://researchcomputing.princeton.edu/slurm)
  - [Slurm overview](https://slurm.schedmd.com/overview.html)
  - [Slurm commands reference
    sheet](https://slurm.schedmd.com/pdfs/summary.pdf)


## Slurm submission options

### Though `Sbatch` headers at the begining of the shell script. Below is a template.
```bash
#!/bin/bash
#SBATCH --nodes=1                (number of nodes, i.e., machines; all non-MPI jobs *must* run on a single node, i.e., '--nodes=1' must be given here)
#SBATCH --ntasks=8               (number of tasks; by default, 1 task=1 slot=1 thread)
#SBATCH --mem=8000               (request 8 GB of memory for this job)
#SBATCH --time=1-20:00:00        (wall-time limit for job; here: 1 day and 20 hours)
#SBATCH --job-name=jobname             (change name of job)
#SBATCH --output=jobname.out.%j  (write stdout+stderr to this file; %j willbe replaced by job ID)
#SBATCH --mail-user=email@address.com          (set your email address)
#SBATCH --mail-type=ALL          (send email at job start, end or crash - do not use if this is going to generate thousands of e-mails!)
```
When the script is ready, you can save it as `submit.sh`, for example,
and submit it with `sbatch submit.sh`.

Note that this option is only applicable for `sbatch`, but not `salloc`.

A sample file to submit a matlab script and a python script are included in this repo: `matlab_slurm.sl`,`python_slurm.sh`.

### By appending the options after `sbatch` or `salloc` on command line

For example,

``` bash
sbatch --job-name=somename --nodes=1 --ntasks=6 --mem=4000 submit.sh
```

or

``` bash
salloc --nodes=1 --ntasks=6 --mem=4000
```

This option works for both `sbatch` and `salloc`. Also, note that the
command line options will override the `#SBATCH` headers, so it might be
a good practice to use the headers as default settings and tweak them
with command line when needed.

### Job monitoring and cancel a job
- Use `squeue` to monitor job status
- USe `scancel jobid` to cancel your job

### Job Arrays
If you want to run an identical programs for multiple times, instead of using a for-loop (which requires some shell language), you can submit the script as a job array by adding the following header to the job submission script:
```
#SBATCH --output=pythontest.%A_%a.out
#SBATCH --array=1-3
```

## Using Github with cluster
### Setup personal access Tokens with GIT and Github
To generate a token
- Log into GitHub
- Click on your name / Avatar in the upper right corner and select Settings'
- On the left, click Developer settings
- Select Personal access tokens and click Generate new token
- Give the token a description/name and select the scope of the token
- Click Generate token
- Copy the token – this is your new password! (Save this to a safe place as it will only appear once on the website)

### Confiugre Git on Hopper
```
git config --global user.name ""
git config --global user.email ""
git config -l
git clone "a private repo from our organization and it will ask for your username and the token we just generated)
git config --global credential.helper cache
```

## Reference
- [BSCB Cluster Tutorial](https://github.com/therkildsen-lab/user-guide/blob/master/slurm_tutorial/slurm.md)
- [Job scheduling on HPC resources](https://waterprogramming.wordpress.com/2018/06/25/job-scheduling-on-hpc-resources/)
- [Using Personal Access Tokens with GIT and GitHub](https://www.edgoad.com/2021/02/using-personal-access-tokens-with-git-and-github.html)
