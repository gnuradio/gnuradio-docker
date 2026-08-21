ARG DEBIAN_VERSION=forky
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"

# Debian forky has sccache with S3 support: no need for sccache builder anymore!

FROM debian:${DEBIAN_VERSION}
ARG APT_INSTALL_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
ENV security_updates_as_of=2026-06-02

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
    cmake \
    git \
    pkg-config \
    \
    # appstream-util just disappeared in forky? I never liked appstream, so I'll not sink time \
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
    libasound2t64 \
    libboost-date-time-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    # let's try  without libboost-system-dev, seems to have disappeared \
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
    # for some reason debian forky insists on calling this portaudio19-dev
    # instead of formerly libportaudio-dev
    portaudio19-dev \
    libqt5opengl5-dev \
    libqwt-qt5-6.3 \
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

COPY commona_files/sid.sources /etc/apt/sources.list.d/sid.sources
RUN apt update -q \
    && ${APT_INSTALL_COMMAND} \
    # for caching
    sccache \
    && rm /etc/apt/sources.list.d/sid.sources \
    && apt-get clean \
    && apt-get autoclean

