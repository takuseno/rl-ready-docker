#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

useradd -u $USER_ID -o -m user
groupmod -g $GROUP_ID user
export HOME=/home/user

# install MuJoCo
gosu user wget https://github.com/deepmind/mujoco/releases/download/2.1.0/mujoco210-linux-x86_64.tar.gz
gosu user tar xvf mujoco210-linux-x86_64.tar.gz
gosu user mkdir ~/.mujoco
gosu user mv mujoco210 ~/.mujoco/mujoco210
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/user/.mujoco/mujoco210/bin

echo "Install Python packages for RL"
gosu user pip3 install --no-cache-dir \
    Cython \
    mujoco-py \
    gym[atari,accept-rom-license] \
    patchelf

echo "Verify installation"
gosu user bash /usr/local/bin/test.sh

exec /usr/sbin/gosu user "$@"
