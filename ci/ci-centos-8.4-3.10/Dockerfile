FROM centos:8.4.2105
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2021-11-01

RUN dnf install epel-release -y -q && \
    dnf -y install dnf-plugins-core && \
    dnf --enablerepo=epel check-update -y ;\
    dnf install -y \
# Build
    cmake3 \
# cmake bug requires this to be installed:
    libarchive \
    make \
    gcc \
    gcc-c++ \
    xz \
    ccache \
    clang && \
    dnf config-manager --set-enabled powertools && \
# CPP deps
    dnf install -y \
    boost169-devel \
    log4cpp-devel \
    cppzmq-devel \
    libunwind-devel \
    fmt-devel \
    spdlog-devel \
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
    libusb-devel \
    libxml2-devel \
# Python deps
    python3-devel \
    python3-pybind11 \
    python3-numpy \
    python3-scipy \
    python3-zmq \
    python3-thrift \
    python3-pytest \
    python3-PyYAML \
# GUI libraries
    xdg-utils \
    qwt-qt5-devel \
    python3-PyQt5 \
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
# For VOLK
    git && \
    dnf clean all && \
    pip3 install --upgrade mako

# Install VOLK
RUN mkdir -p /src/build && \
    git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.4.1 --depth 1 && \
    cd /src/build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../volk/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/

# Install libiio
RUN dnf install -y flex bison && \
    dnf clean all && \
    mkdir -p /src/build && \
    git clone --recursive https://github.com/analogdevicesinc/libiio.git /src/libiio --branch 2019_R2 --depth 1 && \
    cd /src/build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../libiio/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/

# Install libiio-ad9361
RUN mkdir -p /src/build && \
    git clone --recursive https://github.com/analogdevicesinc/libad9361-iio.git /src/libiio_ad9361 --branch 2019_R2 --depth 1 && \
    cd /src/build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../libiio_ad9361/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/

# Install SoapySDR
RUN mkdir -p /src \
    && pushd /src \
    && git clone -b soapy-sdr-0.8.0 https://github.com/pothosware/SoapySDR/ \
    && cd SoapySDR \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr .. \
    && make install \
    && popd \
    && rm -rf /src

