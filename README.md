# llama-cpp-server

This is a thin wrapper around [llama-cpp-python](https://github.com/abetlen/llama-cpp-python)
which is an OpenAI compatible wrapper around llama2 alowing the family of models 
to be exposed.

That project already has Dockerfiles but they aren't necessarily all built as
images. It would be an improvement to fix the upstream projects build workflow.

## Approach

- A separate docker image is built for a specific architecture or hardware profile (e.g. gpu type)
- Models are specified as configuration, downloaded, and persisted on a volume outside the container

## Local testing

```
$ docker build -t llama-cpp-server:dev .
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