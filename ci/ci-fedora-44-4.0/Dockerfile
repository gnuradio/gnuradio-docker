ARG FEDORA_VERSION=44
ARG DNF_COMMAND="dnf --setopt=install_weak_deps=False -q"

# Fedora >=43 has sccache, but none with S3 storage support
ARG SCCACHE_VERSION=0.10.0
ARG LIBAD9361_TAG=v0.3
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
        cpp-httplib-devel \
        fftw-devel \
        gtest-devel \
        libsoundio-devel \
        openssl-devel \
        tbb-devel \
        ut-devel \
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

RUN git clone --branch v0.4.4 --depth 1 https://github.com/mattkretz/vir-simd.git /opt/vir-simd \
    && cmake -E copy_directory /opt/vir-simd/vir /usr/local/include/vir \
    && rm -rf /opt/vir-simd

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
