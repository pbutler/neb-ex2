#!/bin/bash

#SBATCH --job-name=benchmark-containers
#SBATCH --output=results/bcontainers-%j-%n.out
#SBATCH --error=results/bcontainers-%j-%n.err
#SBATCH --nodes=2 
#SBATCH --cpus-per-task=64
#SBATCH --gpus-per-node=8
#SBATCH --mem=0
#SBATCH --container-env=HEAD_NODE_ADDR

export HEAD_NODE_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
echo $HEAD_NODE_ADDR
# Run a job in a container
HEAD_NODE_ADDR=$HEAD_NODE_ADDR HEAD_NODE_PORT2=29400 srun --container-image="ghcr.io#pbutler/neb-ex2:latest" --container-env=HEAD_NODE_ADDR --container-env=HEAD_NODE_PORT2 --container-env=NCCL_IB_DISABLE wrapper.sh
