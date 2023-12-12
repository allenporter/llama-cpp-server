# llama-cpp-server

Docker containers for [llama-cpp-python](https://github.com/abetlen/llama-cpp-python)
which is an OpenAI compatible wrapper around llama2. The motivation is to have
prebuilt containers for use in kubernetes.

Ideally we should just update llama-cpp-python to publish usable containers.

## Approach

- A separate docker image is built for a specific architecture or hardware profile (e.g. gpu type)
- Models are downloaded separately (e.g. from k8s init container)

## Local testing

```
$ docker build -t llama-cpp-server:dev -f Dockerfile.simple .
$ MODEL_NAME=mistral-7b
$ MODEL_URL=https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf
$ mkdir models
$ docker run \
    -e MODEL_URL=${MODEL_URL} \
    -e MODEL_NAME=${MODEL_NAME} \
    -e MODEL_DIR=/data/models \
    -v ./models:/data/models:rw \
    -p 8000:8000 \
    -t llama-cpp-server:dev
```

## Development

Work to do:
- [x] Initial skeleton
- [ ] k8s resources
- [ ] helm chart