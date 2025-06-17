#!/bin/bash

if [ -d ./.venv ]; then
	source .venv/bin/activate
fi

NNODES=${SLURM_NNODES:-1}
GPUS_PER_NODE=${GPUS_PER_NODE:-8}
HEAD_NODE_ADDR=${HEAD_NODE_ADDR:-$MASTER_ADDR}
HEAD_NODE_PORT=${HEAD_NODE_PORT:-29400}
# For some unknown reason outside of a container this only runs if the ports
# are the same but fails if they are the same in a container, for some versions
# of the pytorch container
HEAD_NODE_PORT2=${HEAD_NODE_PORT2:-29400}
MYRANK=${SLURM_NODEID:-0}
ID=${ID:-42}

NCCL_P2P_DISABLE=1
NCCL_SHM_DISABLE=1
NCCL_ALGO="Ring"

echo torchrun --nnodes $NNODES --nproc-per-node $GPUS_PER_NODE --node-rank $MYRANK  --rdzv-backend c10d --rdzv-endpoint ${HEAD_NODE_ADDR}:${HEAD_NODE_PORT} --rdzv-id $ID ./benchmark.py --master-addr $HEAD_NODE_ADDR --master-port $HEAD_NODE_PORT2 --world-size $((NNODES * GPUS_PER_NODE)) 
torchrun --nnodes $NNODES --nproc-per-node $GPUS_PER_NODE --node-rank $MYRANK  --rdzv-backend c10d --rdzv-endpoint ${HEAD_NODE_ADDR}:${HEAD_NODE_PORT} --rdzv-id $ID ./benchmark.py --master-addr $HEAD_NODE_ADDR --master-port $HEAD_NODE_PORT2 --world-size $((NNODES * GPUS_PER_NODE)) 
