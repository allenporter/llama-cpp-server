# llama-cpp-server

Docker containers for [llama-cpp-python](https://github.com/abetlen/llama-cpp-python)
which is an OpenAI compatible wrapper around llama2. The motivation is to have
prebuilt containers for use in kubernetes.

Ideally we should just update llama-cpp-python to automate publishing containers.

## Configuration

See https://llama-cpp-python.readthedocs.io/en/latest/server/#configuration-and-multi-model-support
and set the `CONFIG_FILE`` environment variable.
