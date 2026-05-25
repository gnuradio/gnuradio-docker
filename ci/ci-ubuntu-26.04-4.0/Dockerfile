ARG UBUNTU_VERSION=26.04
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"


FROM ubuntu:${UBUNTU_VERSION}
ARG APT_INSTALL_COMMAND

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PKG_CONFIG=pkg-config \
    CC=gcc \
    CXX=g++

RUN apt-get update -q \
    && apt-get -y upgrade \
    && ${APT_INSTALL_COMMAND} \
        bash \
        build-essential \
        ca-certificates \
        ccache \
        cmake \
        file \
        git \
        locales \
        make \
        ninja-build \
        pkg-config \
        wget \
        cppzmq-dev \
        libboost-system-dev \
        libbrotli-dev \
        libcurl4-openssl-dev \
        libcpp-httplib-dev \
        libfftw3-dev \
        libgtest-dev \
        libssl-dev \
        libtbb-dev \
        nlohmann-json3-dev \
        python3 \
        python3-dev \
        python3-numpy \
        pybind11-dev \
        libcli11-dev \
        librtaudio-dev \
        libportaudio2 \
        libsoapysdr-dev \
        soapysdr-module-hackrf \
        soapysdr-tools \
        gcc \
        g++ \
        clang \
        libclang-rt-dev \
        libc++-dev \
        libc++abi-dev \
        libunwind-dev \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*
