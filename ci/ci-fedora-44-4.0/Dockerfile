ARG FEDORA_VERSION=44
ARG DNF_COMMAND="dnf --setopt=install_weak_deps=False -q"

# Fedora >=43 has sccache, but none with S3 storage support
ARG SCCACHE_VERSION=0.10.0
ARG LIBAD9361_TAG=v0.3
# the gr-deps superbuild provides GNU Radio 4's third-party dependencies at the versions gr-core requires
ARG GR_DEPS_REPOSITORY=https://github.com/gnuradio/gnuradio4-deps.git
ARG GR_DEPS_REF=d4ba883c9c72723158b764c9efe57088d470cc86
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
        && ${DNF_COMMAND} clean all

RUN cargo install \
        --locked \
        --quiet \
        --target-dir /build \
        --root /target \
        sccache@${SCCACHE_VERSION} \
        && rm -rf /build

FROM fedora:${FEDORA_VERSION}
ARG DNF_COMMAND
ARG GR_DEPS_REPOSITORY
ARG GR_DEPS_REF

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PKG_CONFIG=pkg-config \
    CC=clang \
    CXX=clang++

RUN ${DNF_COMMAND} update -y \
    && ${DNF_COMMAND} install -y \
        bash \
        ccache \
        ca-certificates \
        cmake \
        file \
        findutils \
        gcc \
        gcc-c++ \
        git \
        gnupg2 \
        lsb_release \
        make \
        ninja-build \
        pkgconf-pkg-config \
        python3 \
        python3-devel \
        python3-numpy \
        pybind11-devel \
        wget \
        cppzmq-devel \
        boost-devel \
        brotli-devel \
        libcurl-devel \
        cpr-devel \
        fftw-devel \
        gtest-devel \
        libsoundio-devel \
        openssl-devel \
        tbb-devel \
        json-devel \
        cli11-devel \
        rtaudio-devel \
        portaudio-devel \
        SoapySDR-devel \
        clang \
        compiler-rt \
        libcxx-devel \
        libcxxabi-devel \
        libunwind-devel \
    && ${DNF_COMMAND} clean all

ENV GR_DEPS_PREFIX=/opt/gr-deps
RUN git clone ${GR_DEPS_REPOSITORY} /tmp/gr-deps \
    && git -C /tmp/gr-deps checkout ${GR_DEPS_REF} \
    && cmake -S /tmp/gr-deps -B /tmp/gr-deps/build -G Ninja \
        -DCMAKE_INSTALL_PREFIX=${GR_DEPS_PREFIX} \
        -DENABLE_PYTHON3=OFF \
    && cmake --build /tmp/gr-deps/build \
    && rm -rf /tmp/gr-deps
ENV CMAKE_PREFIX_PATH=${GR_DEPS_PREFIX}

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
