# rl-ready-docker

Dockerfile for RL-ready contrainer.

## installed environments
- MuJoCo (mujoco-py)
- Atari 2600 (atari-py)

## usage
```
$ git clone https://github.com/takuseno/rl-ready-docker
$ cd rl-ready-docker
$ ./build.sh
$ export PATH=$(pwd)/bin:$PATH
$ run-rl-ready-docker  # start with the current directory mounted
```

## commands
- run-rl-ready-docker: Start a new container with mounting the current working directory.
