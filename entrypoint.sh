#!/bin/bash -eux

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

useradd -u $USER_ID -G sudo -o -m -s /bin/bash user
groupmod -g $GROUP_ID user
echo 'user:password' | chpasswd
echo 'Defaults visiblepw' >> /etc/sudoers
echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
export HOME=/home/user

# install MuJoCo
gosu user wget https://github.com/deepmind/mujoco/releases/download/2.1.0/mujoco210-linux-x86_64.tar.gz
gosu user tar xvf mujoco210-linux-x86_64.tar.gz
gosu user mkdir ~/.mujoco
gosu user mv mujoco210 ~/.mujoco/mujoco210
gosu user rm mujoco210-linux-x86_64.tar.gz
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/user/.mujoco/mujoco210/bin
# fix mujoco_py compilation
ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /opt/conda/lib/libstdc++.so.6

echo "Install Python packages for RL"
gosu user pip3 install --no-cache-dir \
    Cython==0.29.36 \
    mujoco-py \
    gym[atari,accept-rom-license] \
    opencv-python \
    git+https://github.com/takuseno/D4RL \
    patchelf
gosu user pip3 uninstall -y pybullet 
gosu user pip3 install --no-cache-dir -U gym

# install mpi4py
rm -r /opt/conda/compiler_compat/ld
ln -s /usr/bin/ld /opt/conda/compiler_compat/ld
gosu user pip3 install mpi4py==3.1.6


echo "Verify installation"
gosu user bash /usr/local/bin/test.sh

exec /usr/sbin/gosu user "$@"
