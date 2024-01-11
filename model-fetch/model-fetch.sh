#!/bin/ash
#
# MODEL_URLS: comma separated list of urls to download
# MODEL_DIR: directory to download models to
# FORCE_DOWNLOAD: if true, force download even if file exists
# 

set -e

: ${MODEL_DIR:="/data/models"}
: ${FORCE_DOWNLOAD:="false"}

if [ -z "${MODEL_DIR}" ]; then
  echo "Required env MODEL_DIR not set"
  exit 1
fi
if [ -z "${MODEL_URLS}" ]; then
  echo "Required env MODEL_URLS not set"
  exit 1
fi

mkdir -p ${MODEL_DIR}
echo "Using model directory: ${MODEL_DIR}"

# Split urls on commas
echo "${MODEL_URLS}" | awk -F, '{for (i=1; i<=NF; i++) print $i}' | while read -r line; do
    url=$(echo "$line" | awk '{print $1}')

    if [ -n "$url" ]; then
        echo "Processing $url"
        filename=$(basename "$url")

        if [ "$FORCE_DOWNLOAD" != "true" ] && [ -f "$MODEL_DIR/$filename" ]; then
            echo "File $filename already exists. Skipping download."
            continue
        fi
        rm -f "$MODEL_DIR/$filename"

        echo "Downloading $filename"
        wget "$url" -O "$MODEL_DIR/$filename"

        if [ "$?" -ne 0 ]; then
            echo "Download failed."
        else
            echo "Download completed."
        fi
    fi
done
