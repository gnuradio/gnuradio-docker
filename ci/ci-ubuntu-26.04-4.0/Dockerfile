ARG UBUNTU_VERSION=26.04
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"
# the gr-deps superbuild provides GNU Radio 4's third-party dependencies at the versions gr-core requires
ARG GR_DEPS_REPOSITORY=https://github.com/gnuradio/gnuradio4-deps.git
ARG GR_DEPS_REF=d4ba883c9c72723158b764c9efe57088d470cc86

FROM ubuntu:${UBUNTU_VERSION}
ARG APT_INSTALL_COMMAND
ARG GR_DEPS_REPOSITORY
ARG GR_DEPS_REF

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
        sccache \
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
        libcpr-dev \
        libfftw3-dev \
        libgtest-dev \
        libsoundio-dev \
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

ENV GR_DEPS_PREFIX=/opt/gr-deps
RUN git clone ${GR_DEPS_REPOSITORY} /tmp/gr-deps \
    && git -C /tmp/gr-deps checkout ${GR_DEPS_REF} \
    && cmake -S /tmp/gr-deps -B /tmp/gr-deps/build -G Ninja \
        -DCMAKE_INSTALL_PREFIX=${GR_DEPS_PREFIX} \
        -DENABLE_PYTHON3=OFF \
    && cmake --build /tmp/gr-deps/build \
    && rm -rf /tmp/gr-deps
ENV CMAKE_PREFIX_PATH=${GR_DEPS_PREFIX}
