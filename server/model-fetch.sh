#!/bin/bash

set -e

if [ -z "${MODEL_DIR}" ]; then
  echo "Required env MODEL_DIR not set"
  exit 1
fi
if [ -z "${MODEL_NAME}" ]; then
  echo "Required env MODEL_NAME not set"
  exit 1
fi

mkdir -p ${MODEL_DIR}
echo "Using model directory: ${MODEL_DIR}"

MODEL_FILE="${MODEL_DIR}/${MODEL_NAME}.gguf"

if [ ! -f "${MODEL_FILE}" ]; then
    echo "Model ${MODEL_FILE} not found"

    if [ -z "${MODEL_URL}" ]; then
        echo "Required env MODEL_URL not set"
        exit 1
    fi

    echo "Downloading ${MODEL_NAME} from ${MODEL_URL}"
    echo "Writing to ${MODEL_FILE}"
    curl -L ${MODEL_URL} -o ${MODEL_FILE}
else
    echo "Found existing model ${MODEL_FILE}"
fi