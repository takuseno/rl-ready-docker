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
        libpcre3-dev && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# install MuJoCo
RUN wget https://github.com/deepmind/mujoco/releases/download/2.1.0/mujoco210-linux-x86_64.tar.gz && \
    tar xvf mujoco210-linux-x86_64.tar.gz && \
    mkdir ~/.mujoco && \
    mv mujoco210 ~/.mujoco/mujoco210
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/root/.mujoco/mujoco210/bin

# install Python packages
RUN pip3 install --no-cache-dir \
        Cython \
        mujoco-py \
        gym[atari,accept-rom-license] \
        patchelf

# verify installation
COPY test.sh /tmp/test.sh
RUN /tmp/test.sh

# tensorbord port
EXPOSE 6006

CMD ["tail", "-f", "/dev/null"]
