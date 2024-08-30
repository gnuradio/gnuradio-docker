FROM debian:bullseye
LABEL maintainer="mmueller@gnuradio.org"

ENV security_updates_as_of 2021-08-16

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    libasound2 \
    libfftw3-bin \
    libgmp10 \
    libgtk-3-0 \
    libjack-jackd2-0 \
    liblog4cpp5v5 \
    libspdlog-dev \
    libfmt-dev \
    libpangocairo-1.0-0 \
    libportaudio2 \
    libqwt-qt5-6 \
    libsndfile1-dev \
    libsdl-image1.2 \
    libthrift-dev \
    libuhd-dev \
    libusb-1.0-0 \
    libzmq5 \
    libpango-1.0-0 \
    gir1.2-gtk-3.0 \
    gir1.2-pango-1.0 \
    pkg-config \
    thrift-compiler \
    libunwind-dev \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Py3 deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    python3-click \
    python3-click-plugins \
    python3-mako \
    python3-dev \
    python3-gi \
    python3-gi-cairo \
    python3-lxml \
    python3-numpy \
    python3-opengl \
    python3-pyqt5 \
    python3-yaml \
    python3-zmq \
    python3-six \
    python3-pytest \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Build deps
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    --no-install-recommends \
    build-essential \
    ccache \
    cmake \
    pybind11-dev \
    libasio-dev \
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
    libfftw3-dev \
    libgmp-dev \
    libgsl0-dev \
    libgsm1-dev \
    liblog4cpp5-dev \
    libqwt-qt5-dev \
    libqt5opengl5-dev \
    qtbase5-dev \
    libsdl1.2-dev \
    libuhd-dev \
    libzmq3-dev \
    portaudio19-dev \
    pyqt5-dev-tools \
    libsoapysdr-dev \
    doxygen \
    doxygen-latex \
    && apt-get clean \
    && apt-get autoclean

# Testing deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    xvfb \
    lcov \
    python3-scipy \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Install other dependencies (e.g. VOLK)
RUN apt-get -y install -q \
    git \
    ca-certificates \
    appstream-util \
    --no-install-recommends && \
    apt-get clean && \
    apt-get autoclean


# Install VOLK
## Don't need to build from source – debian happens to ship exactly 2.4.1.
# RUN mkdir -p /src/build && \
#     git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.4.1 && \
#     cd /src/build && \
#     cmake -DCMAKE_BUILD_TYPE=Release ../volk/ && \
#     make -j8&& \
#     make install && \
#     cd / && \
#     rm -rf /src/
RUN apt-get install -qy libvolk2-dev \
    && apt-get clean \
    && apt-get autoclean

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
