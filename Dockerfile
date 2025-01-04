# Base image with Ubuntu 20.04 (CARLA officially supports this version)
FROM nvidia/cuda:11.6.2-base-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install required dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    curl \
    gnupg \
    python3-pip \
    python3-dev \
    python-is-python3 \
    git \
    unzip \
    sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install CARLA-specific dependencies
RUN pip3 install --no-cache-dir pygame numpy

# Add CARLA's Debian repository key and repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1AF1527DE64CB8D9 && \
    add-apt-repository "deb [arch=amd64] http://dist.carla.org/carla focal main"

# Install the CARLA simulator
RUN apt-get update && apt-get install -y carla-simulator && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set CARLA simulator path
WORKDIR /opt/carla-simulator

# Expose required ports
EXPOSE 2000 2001

# Start CARLA server
CMD ["./CarlaUE4.sh", "-opengl"]
