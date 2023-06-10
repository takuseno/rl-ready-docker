# rl-ready-docker

Dockerfile for RL-ready contrainer.

## installed environments
- MuJoCo (mujoco-py)
- Atari 2600 (atari-py)

## build
```
$ docker build -t takuseno/rl-ready:latest .
```

## command
```
export PATH=$HOME/<path-to-repo>/rl-ready-docker/bin:$PATH
```

- run-rl-ready-docker: Start a new container with mounting the current working directory.
