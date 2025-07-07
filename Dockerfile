ARG CUDA_VERSION=12.4.1
FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04 AS base

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    PUB_MULTI_ADDRS="" \
    PEER_MULTI_ADDRS="/ip4/38.101.215.13/tcp/30002/p2p/QmQ2gEXoPJg6iMBSUFWGzAabS2VhnzuS782Y637hGjfsRJ" \
    HOST_MULTI_ADDRS="/ip4/0.0.0.0/tcp/38331" \
    IDENTITY_PATH="/swarm.pem" \
    CONNECT_TO_TESTNET="true" \
    ORG_ID="" \
    HF_HUB_DOWNLOAD_TIMEOUT=120 \
    PARAM_B="0.5" \
    USE_BIG_SWARM="false" \
    HUGGINGFACE_ACCESS_TOKEN="None"

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    ca-certificates \
    gnupg \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.10 python3.10-venv python3.10-dev \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3.10 /usr/bin/python

# Install pip and Python dependencies
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && rm get-pip.py \
    && pip install --upgrade pip

# Set working directory
WORKDIR /

# Install Python dependencies
RUN pip install flash-attn --no-build-isolation

# Copy the rest of the application
COPY . .

# Install modal-login dependencies
RUN cd modal-login && yarn install

# Make the script executable
RUN chmod +x ./run_rl_swarm.sh

# Expose ports for the web interface and swarm communication
EXPOSE 3000 8080

# Command to run the swarm
CMD ["bash", "./run_rl_swarm.sh"]
