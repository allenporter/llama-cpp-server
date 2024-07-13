# llama-cpp-server

Docker containers for [llama-cpp-python](https://github.com/abetlen/llama-cpp-python)
which is an OpenAI compatible wrapper around llama2. The motivation is to have
prebuilt containers for use in kubernetes.

Ideally we should just update llama-cpp-python to automate publishing containers
and support automated model fetching from urls.

## Images

| Image | Description |
| ----- | ----------- |
| `ghcr.io/allenporter/llama-cpp-server-cuda` | Preferred on NVidia GPUs |
| `ghcr.io/allenporter/llama-cpp-server-cpu` | Preferred for CPUs |
| `ghcr.io/allenporter/llama-cpp-server-functionary-v2.5` | CUDA version that supports functionary-v2.5 |


## Examples

Below are examples using the container images.

### Fetching models

The container is packaged with `huggingface-cli` for pre-downloading models. llama-cpp-python
will download models if specified by the hf repo id, however its not supported for all fields
yet (e.g. tokenizer config).

Download supporting model files except gguf files:

```bash
$ docker run -it \
    -v "./models/:/data/models" \
    -v "./models/cache/:/root/.cache" \
    --entrypoint huggingface-cli \
    ghcr.io/allenporter/llama-cpp-server-cpu:v2.21.1 \
        download TheBloke/Mistral-7B-Instruct-v0.1-GGUF \
        --exclude '*.gguf' \
        --local-dir=/data/models/Mistral-7B-Instruct-v0.1 
```
 
Download the specific gguf model:

```
$ docker run -it \
    -v "./models/:/data/models" \
    -v "./models/cache/:/root/.cache" \
    --entrypoint huggingface-cli \
    ghcr.io/allenporter/llama-cpp-server-cpu:v2.21.1 \
        download TheBloke/Mistral-7B-Instruct-v0.1-GGUF \
        mistral-7b-instruct-v0.1.Q4_K_M.gguf \
        --local-dir=/data/models/Mistral-7B-Instruct-v0.1

```

### Running a server

See [Configuration](https://llama-cpp-python.readthedocs.io/en/latest/server/#configuration-and-multi-model-support) for
more details on the config file format.

```bash
$ docker run -it \
    -v "./models/:/data/models" \
    -v "./config/:/data" \
    -v "./models/cache/:/root/.cache" \
    -e "CONFIG_FILE=/data/config.json" \
    -p "8000:8000" \
    ghcr.io/allenporter/llama-cpp-server-cpu:v2.21.1
```
