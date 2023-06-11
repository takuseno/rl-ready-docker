FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel

# this needs to avoid time zone question
ENV DEBIAN_FRONTEND=noninteractive

# install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        software-properties-common \
        cmake \
        pkg-config \
        git \
        wget \
        unzip \
        unrar \
        python3-dev \
        python3-tk \
        python3-pip \
        zlib1g \
        zlib1g-dev \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libglu1-mesa-dev \
        libasio-dev \
        libsm6 \
        libxext6 \
        libxrender1 \
        libosmesa6-dev \
        libglfw3 \
        libpcre3-dev \
        gosu && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

COPY test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# tensorbord port
EXPOSE 6006

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
