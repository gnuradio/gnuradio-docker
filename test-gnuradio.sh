#!/bin/sh

docker run -it --rm \
    --name gnuradio-test \
    --net=host \
    -e DISPLAY \
    -v $HOME/.Xauthority:/home/user/.Xauthority \
    gnuradio/gnuradio-python-minimal
