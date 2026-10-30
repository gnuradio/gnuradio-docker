ARG UBUNTU_VERSION=24.04
ARG SCCACHE_VERSION=0.10.0
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"
ARG EMSDK_VERSION=5.0.2
# the gr-deps superbuild provides GNU Radio 4's third-party dependencies at the versions gr-core requires
ARG GR_DEPS_REPOSITORY=https://github.com/gnuradio/gnuradio4-deps.git
ARG GR_DEPS_REF=d4ba883c9c72723158b764c9efe57088d470cc86


FROM ubuntu:${UBUNTU_VERSION} AS sccache-builder
ARG SCCACHE_VERSION
ARG APT_INSTALL_COMMAND
LABEL maintainer="mmueller@gnuradio.org"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q ;\
    ${APT_INSTALL_COMMAND} \
    cargo \
    ca-certificates \
    pkg-config \
    libssl-dev \
    && apt-get clean
RUN cargo install \
    --locked \
    --quiet \
    --target-dir /build \
    --root /target \
    sccache@${SCCACHE_VERSION} \
    && rm -rf /build


FROM ubuntu:${UBUNTU_VERSION}
ARG APT_INSTALL_COMMAND
ARG EMSDK_VERSION
ARG GR_DEPS_REPOSITORY
ARG GR_DEPS_REF

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

# The Emscripten toolchain file roots every package search in its sysroot, so the dependencies install there and
# need no search path. All of them are header-only with architecture-independent package files, so the host compiler
# configures them.
RUN . ${EMSDK_HOME}/emsdk_env.sh \
    && export CC=gcc CXX=g++ \
    && emscripten_sysroot="$(em-config CACHE)/sysroot" \
    && git clone ${GR_DEPS_REPOSITORY} /tmp/gr-deps \
    && git -C /tmp/gr-deps checkout ${GR_DEPS_REF} \
    && cmake -S /tmp/gr-deps -B /tmp/gr-deps/build -G Ninja \
        -DCMAKE_INSTALL_PREFIX="${emscripten_sysroot}" \
        -DENABLE_PYTHON3=OFF \
    && cmake --build /tmp/gr-deps/build \
    && chmod -R a+rwX "${emscripten_sysroot}" \
    && rm -rf /tmp/gr-deps

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
