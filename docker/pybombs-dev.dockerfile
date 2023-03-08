ARG dist=ubuntu:jammy
FROM $dist
ARG gr_version=gnuradio310
RUN apt update && apt install -y python3-pip
RUN pip3 install pybombs
RUN pybombs auto-config
RUN pybombs recipes add-defaults
RUN DEBIAN_FRONTEND="noninteractive" pybombs --quiet --yes prefix init ~/prefix-3.10 -R $gr_version
