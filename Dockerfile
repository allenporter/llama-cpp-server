FROM python:3.11-slim-bullseye

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        python3 \
        python3-pip \
        build-essential \
        curl \
        && \
    python3 -m pip install --upgrade pip && \
    rm -rf /var/lib/apt/lists/*

ENV SERVER_DIR=/var/lib/llama
RUN mkdir -p $SERVER_DIR

COPY requirements.txt $SERVER_DIR
RUN pip3 install -r $SERVER_DIR/requirements.txt

ENV LLAMA_CPP_PYTHON_VERSION=0.2.20
RUN pip3 install llama_cpp_python[server]==$LLAMA_CPP_PYTHON_VERSION

# Prepare server environment
COPY server/start.sh $SERVER_DIR/start.sh
RUN chmod +x $SERVER_DIR/start.sh

ENV MODEL_URL=""
ENV MODEL_NAME=""
ENV MODEL_DIR=/data/models
WORKDIR $SERVER_DIR

# We need to set the host to 0.0.0.0 to allow outside access
ENV HOST=0.0.0.0

EXPOSE 8000
ENTRYPOINT ["./start.sh"]