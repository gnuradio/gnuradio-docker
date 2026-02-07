ARG DEBIAN_VERSION=13
ARG SCCACHE_VERSION=0.10.0
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"

# Debian 13 has sccache, but none with S3 support.
# So we need to build that ourselves.
FROM debian:${DEBIAN_VERSION} AS sccache-builder
ARG SCCACHE_VERSION
ARG APT_INSTALL_COMMAND
LABEL maintainer="mmueller@gnuradio.org"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q ;\
    ${APT_INSTALL_COMMAND} \
    ca-certificates \
    curl \
    tar \
    cargo \
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

FROM debian:${DEBIAN_VERSION}
ARG APT_INSTALL_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
ENV security_updates_as_of 2026-02-07

ENV DEBIAN_FRONTEND=noninteractive

# Prepare distribution
RUN \
    apt-get update -q ;\
    apt-get -y upgrade \
    && ${APT_INSTALL_COMMAND} \
    ca-certificates \
    && apt-get clean \
    && apt-get autoclean

# CPP / base dev deps
RUN \
    apt-get update -q ;\
    ${APT_INSTALL_COMMAND} \
    \
    build-essential \
    sccache \
    cmake \
    git \
    pkg-config \
    \
    appstream-util \
    doxygen \
    doxygen-latex \
    pybind11-dev \
    thrift-compiler \
    \
    cppzmq-dev \
    gir1.2-gtk-3.0 \
    gir1.2-pango-1.0 \
    libad9361-dev \
    libasio-dev \
    libasound2 \
    libboost-date-time-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libcodec2-dev \
    libcppunit-dev \
    libfftw3-bin \
    libfftw3-dev \
    libfmt-dev \
    libgmp-dev \
    libgmp10 \
    libgsl0-dev \
    libgsm1-dev \
    libgtk-3-0 \
    libiio-dev \
    libjack-jackd2-0 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libportaudio2 \
    libqt5opengl5-dev \
    libqwt-qt5-6 \
    libqwt-qt5-dev \
    libsdl-image1.2 \
    libsdl1.2-dev \
    libsndfile1-dev \
    libsoapysdr-dev \
    libspdlog-dev \
    libthrift-dev \
    libuhd-dev \
    libunwind-dev \
    libusb-1.0-0 \
    libvolk-bin \
    libvolk-dev \
    libzmq3-dev \
    libzmq5 \
    portaudio19-dev \
    pyqt5-dev-tools \
    qtbase5-dev \
    && apt-get clean \
    && apt-get autoclean

# Py3 deps
RUN \
    ${APT_INSTALL_COMMAND} \
    python3-click \
    python3-click-plugins \
    python3-dev \
    python3-gi \
    python3-gi-cairo \
    python3-jsonschema \
    python3-lxml \
    python3-mako \
    python3-numpy \
    python3-opengl \
    python3-pyqt5 \
    python3-pytest \
    python3-yaml \
    python3-zmq \
    python3-pygccxml \
    && apt-get clean \
    && apt-get autoclean

# Testing deps
RUN \
    ${APT_INSTALL_COMMAND} \
    xvfb \
    lcov \
    python3-scipy \
    clang-format \
    # for bundling up results
    squashfs-tools \
    && apt-get clean \
    && apt-get autoclean

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
