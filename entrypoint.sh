#!/bin/bash -eux

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
gosu user rm mujoco210-linux-x86_64.tar.gz
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/user/.mujoco/mujoco210/bin

echo "Install Python packages for RL"
gosu user pip3 install --no-cache-dir \
    Cython==0.29.36 \
    mujoco-py \
    gym[atari,accept-rom-license] \
    opencv-python \
    git+https://github.com/Farama-Foundation/D4RL \
    patchelf
gosu user pip3 uninstall -y pybullet
gosu user pip3 install --no-cache-dir -U gym

echo "Verify installation"
gosu user bash /usr/local/bin/test.sh

exec /usr/sbin/gosu user "$@"
