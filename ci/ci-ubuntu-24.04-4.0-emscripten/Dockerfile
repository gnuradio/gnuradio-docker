ARG UBUNTU_VERSION=24.04
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"
ARG EMSDK_VERSION=5.0.2


FROM ubuntu:${UBUNTU_VERSION}
ARG APT_INSTALL_COMMAND
ARG EMSDK_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    EMSDK_HOME=/opt/emsdk \
    EMSDK_VERSION=${EMSDK_VERSION} \
    CMAKE_MAKE_PROGRAM=ninja \
    CCACHE_DIR=/tmp/ccache \
    NODE_PATH=/usr/local/lib/node_modules \
    CC=emcc \
    CXX=em++ \
    PATH=/opt/emsdk:/opt/emsdk/upstream/emscripten:${PATH}

RUN apt-get update -q \
    && apt-get -y upgrade \
    && ${APT_INSTALL_COMMAND} \
        bash \
        bzip2 \
        ca-certificates \
        ccache \
        cmake \
        file \
        g++-14 \
        gcc-14 \
        git \
        make \
        ninja-build \
        nodejs \
        npm \
        python3 \
        xz-utils \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${EMSDK_HOME} \
    && git clone --depth 1 https://github.com/emscripten-core/emsdk.git ${EMSDK_HOME} \
    && ${EMSDK_HOME}/emsdk install ${EMSDK_VERSION} \
    && ${EMSDK_HOME}/emsdk activate ${EMSDK_VERSION} \
    && npm install --ignore-scripts -g xhr2 \
    && . ${EMSDK_HOME}/emsdk_env.sh \
    && embuilder build sdl3 \
    && chmod -R a+rwX ${EMSDK_HOME}

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 140 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-14 \
        --slave /usr/bin/gcov gcov /usr/bin/gcov-14 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-14 140
