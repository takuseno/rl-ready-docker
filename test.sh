#!/bin/bash -eux

# test MuJoCo
python3 -c "import gym; env = gym.make('Hopper-v2')"

# test Atari 2600
python3 -c "import gym; env = gym.make('Pong-v0')"
