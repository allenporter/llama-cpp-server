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
| `ghcr.io/allenporter/llama-cpp-server-model-fetch` | Helper container for downloading models from URLs |
## Examples

Below are examples using the container images.

### Fetching models

Fetch a model:

```bash
$ docker run -it \
    -v "./models/:/data/models:rw" \
    -e "MODEL_URLS=https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf" \
    ghcr.io/allenporter/llama-cpp-server-model-fetch:main
```

### Running a server

See [Configuration](https://llama-cpp-python.readthedocs.io/en/latest/server/#configuration-and-multi-model-support) for
more details on the config file format.

```bash
$ docker run -it \
    -v "./models/:/data/models" \
    -v "./config/:/data" \
    -e "CONFIG_FILE=/data/config.json" \
    -p "8000:8000" \
    ghcr.io/allenporter/llama-cpp-server-openblas:main
```

## Local development

Build the model fetcher:
```bash
$ docker build -t model-fetch:dev model-fetch/
```

Fetch a model:
```bash
$ docker run -it \
    -v "./models/:/data/models:rw" \
    -e "MODEL_URLS=https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf" \
    model-fetch:dev
```
