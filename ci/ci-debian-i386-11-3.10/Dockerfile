FROM i386/debian:bullseye
LABEL maintainer="mmueller@gnuradio.org"

ENV security_updates_as_of 2024-05-16

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade \
    && apt-get clean \
    && apt-get autoclean

# Build deps
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    --no-install-recommends \
    appstream-util \
    build-essential \
    ca-certificates \
    ccache \
    cmake \
    doxygen \
    doxygen-latex \
    git \
    pkg-config \
    thrift-compiler \
    && apt-get clean \
    && apt-get autoclean

# Testing deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    lcov \
    xvfb \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    gir1.2-gtk-3.0 \
    gir1.2-pango-1.0 \
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
    libjack-jackd2-0 \
    liblog4cpp5-dev \
    liblog4cpp5v5 \
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
    libuhd-dev \
    libunwind-dev \
    libusb-1.0-0 \
    libvolk2-dev \
    libzmq3-dev \
    libzmq5 \
    portaudio19-dev \
    pybind11-dev \
    pyqt5-dev-tools \
    qtbase5-dev \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Py3 deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    python3-click \
    python3-click-plugins \
    python3-dev \
    python3-gi \
    python3-gi-cairo \
    python3-lxml \
    python3-mako \
    python3-numpy \
    python3-opengl \
    python3-pygccxml \
    python3-pyqt5 \
    python3-pytest \
    python3-scipy \
    python3-six \
    python3-yaml \
    python3-zmq \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Install libad9361
RUN apt-get install -qy libiio-dev \
    && apt-get clean \
    && apt-get autoclean \
    && mkdir -p /src/build && \
    git clone https://github.com/analogdevicesinc/libad9361-iio /src/libad9361 --branch v0.2 --depth 1 && \
    cd /src/build && cmake -DCMAKE_BUILD_TYPE=Release ../libad9361/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/
