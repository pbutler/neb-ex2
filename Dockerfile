FROM nvcr.io/nvidia/pytorch:25.05-py3
LABEL org.opencontainers.image.source=https://github.com/pbutler/neb-ex2
#nvcr.io/nvidia/pytorch:24.07-py3

#ENV NNODES=1 GPUS_PER_NODE=8 HEAD_NODE_ADDR=127.0.0.1 HEAD_NODE_PORT=29400 HEAD_NODE_PORT2=29401 MYRANK=0

COPY --chmod=755 benchmark.py /workspace/benchmark.py
COPY --chmod=755 wrapper.sh /workspace/wrapper.sh
CMD ["/workspace/wrapper.sh"]

