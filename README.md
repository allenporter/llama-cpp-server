# llama-cpp-server

Docker containers for [llama-cpp-python](https://github.com/abetlen/llama-cpp-python)
which is an OpenAI compatible wrapper around llama2. The motivation is to have
prebuilt containers for use in kubernetes.

Ideally we should just update llama-cpp-python to automate publishing containers.

## Configuration

See https://llama-cpp-python.readthedocs.io/en/latest/server/#configuration-and-multi-model-support
and set the `CONFIG_FILE`` environment variable.

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
