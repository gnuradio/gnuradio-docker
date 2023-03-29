FROM fedora:36
LABEL maintainer="jmorman@gnuradio.org"

ENV security_updates_as_of 2022-07-21

# Build
RUN dnf install --refresh -y \
        cmake \
        gcc \
        gcc-c++ \
        clang \
# CPP deps
        boost-devel \
        spdlog-devel \
        fmt-devel \
        yaml-cpp-devel \
        gtest-devel \
        cppzmq-devel \
# Math libraries
        fftw-devel \
        gsl-devel \
        gmp-devel \
        volk-devel \
# Documentation
        doxygen \
        graphviz \
# gr-soapy
        SoapySDR-devel \
# Python deps
        python3-devel \
        python3-pybind11 \
        python3-numpy \
        python3-pip \
# GUI libraries
        xdg-utils \
        qwt-qt5-devel \
        python3-PyQt5 \
        python3-qt5-devel \
# GRC/next
        python3-pyyaml \
        python3-lxml \
        python3-gobject \
	      gtk3 \
        python3-cairo \
        pango \
# Audio, SDL
        SDL-devel \
        alsa-lib-devel \
        portaudio-devel \
        jack-audio-connection-kit-devel \
        libsndfile-devel \
# Git For VOLK and libad9361 source building
        git \
# For ccaching
        ccache \
# For testing metainfo files
        appstream \
        && dnf clean all

RUN pip install meson ninja mako six jinja2 pyyaml zmq jsonschema jsonschema-default packaging

RUN dnf install -y \
        flatbuffers-devel \
        flatbuffers-compiler
