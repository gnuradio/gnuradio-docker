ARG UBUNTU_VERSION=24.04
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"


FROM ubuntu:${UBUNTU_VERSION}
ARG APT_INSTALL_COMMAND

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PKG_CONFIG=pkg-config \
    CC=gcc-14 \
    CXX=g++-14

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
        gpg \
        lsb-release \
        locales \
        make \
        ninja-build \
        pkg-config \
        software-properties-common \
        wget \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && install -d -m 0755 /etc/apt/keyrings \
    && wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /etc/apt/keyrings/llvm.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/llvm.gpg] https://apt.llvm.org/noble/ llvm-toolchain-noble-20 main" > /etc/apt/sources.list.d/llvm20.list \
    && apt-get update -q \
    && ${APT_INSTALL_COMMAND} \
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
        gcc-14 \
        g++-14 \
        libstdc++-14-dev \
        gcc-15 \
        g++-15 \
        libstdc++-15-dev \
        clang-20 \
        libclang-rt-20-dev \
        libc++-20-dev \
        libc++abi-20-dev \
        libunwind-20-dev \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 140 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-14 \
        --slave /usr/bin/gcov gcov /usr/bin/gcov-14 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-15 150 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-15 \
        --slave /usr/bin/gcov gcov /usr/bin/gcov-15 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-14 140 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-15 150 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-20 120 \
    && update-alternatives --set gcc /usr/bin/gcc-14 \
    && update-alternatives --set c++ /usr/bin/g++-14
