#!/bin/bash

set -e
export

: ${N_GPU_LAYERS:=0}

if [ -z "${MODEL_DIR}" ]; then
  echo "Required env MODEL_DIR not set"
  exit 1
fi
if [ -z "${MODEL_NAME}" ]; then
  echo "Required env MODEL_NAME not set"
  exit 1
fi

MODEL_FILE="${MODEL_DIR}/${MODEL_NAME}.gguf"

if [ ! -f "${MODEL_FILE}" ]; then
    echo "Model ${MODEL_FILE} not found"
    exit 1
fi

echo "Running model server with model ${MODEL_FILE} and ${N_GPU_LAYERS} GPU layers"
python3 -m llama_cpp.server --model ${MODEL_FILE} --n_gpu_layers=${N_GPU_LAYERS}