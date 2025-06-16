# --- VERSIONS ---
ARG FEDORA_VERSION=40
ARG SCCACHE_VERSION=0.10.0
ARG LIBAD9361_TAG=v0.3

ARG DNF_COMMAND="dnf --setopt=install_weak_deps=False -q"

# ---- sccache takes a while to build (it's rust…) and
#      quite a bit of space (it's cargo), so:
# avoid rebuilding if version hasn't changed
FROM fedora:${FEDORA_VERSION} AS sccache-builder
ARG SCCACHE_VERSION

ARG DNF_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
RUN ${DNF_COMMAND} install --refresh -y \
        cargo \
        openssl-devel \
        && cargo install \
        --locked \
        --quiet \
        --target-dir /build \
        --root /target \
        sccache@${SCCACHE_VERSION} \
        && ${DNF_COMMAND} clean all \
        && rm -rf /build


FROM fedora:${FEDORA_VERSION}
ARG LIBAD9361_TAG
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2024-06-16

# Build
RUN dnf install --refresh -y \
        cmake \
        make \
        gcc \
        gcc-c++ \
        clang \
        clang-tools-extra \
        xz \
# CPP deps
        asio-devel \
        boost-devel \
        cppzmq-devel \
        spdlog-devel \
        fmt-devel \
# ctrlport - thrift
        thrift \
        thrift-devel \
# Math libraries
        fftw-devel \
        gsl-devel \
        gmp-devel \
# Documentation
        doxygen \
        graphviz \
# Audio, SDL
        SDL-devel \
        alsa-lib-devel \
        portaudio-devel \
        jack-audio-connection-kit-devel \
        libsndfile-devel \
# HW drivers
        uhd-devel \
## Vocoder libraries
        codec2-devel \
        gsm-devel \
# gr-iio
        libiio-devel \
# gr-soapy
        SoapySDR-devel \
# Python deps
        python3-devel \
        python3-pybind11 \
        python3-numpy \
        python3-scipy \
        python3-zmq \
        python3-thrift \
        python3-pytest \
# GUI libraries
        xdg-utils \
        qwt-qt5-devel \
        python3-qt5-devel \
# XML Parsing / GRC
        desktop-file-utils \
        python3-mako \
        python3-click \
        python3-click-plugins \
# GRC/next
        python3-pyyaml \
        python3-lxml \
        python3-gobject \
	      gtk3 \
        python3-cairo \
        pango \
# Git for libad9361 source building
        git \
# For ccaching
        ccache \
# For testing metainfo files
        libappstream-glib \
# Install VOLK
        volk-devel \
        && dnf clean all

# Install libad9361
RUN mkdir -p /src/build && \
    git clone https://github.com/analogdevicesinc/libad9361-iio /src/libad9361 --branch ${LIBAD9361_TAG} --depth 1 && \
    cd /src/build && cmake -DCMAKE_BUILD_TYPE=Release ../libad9361/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/
# Install zsh for hash checker CI
# (Roll into large installation step above for next release)
RUN dnf --refresh install -y zsh  &&\
    dnf clean all
# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
