#!/bin/bash

set -e

uv pip install ruff

ruff check benchmark.py

DISK=$(df -k / | cut -w -f4 | tail -n1)
if [[ ${DISK} -lt 20971520 ]]; then
  echo "Disk space is less than 20GB, skipping benchmark."
  exit 1
fi
