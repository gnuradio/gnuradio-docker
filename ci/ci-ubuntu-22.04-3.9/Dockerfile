ARG UBUNTU_VERSION=22.04
ARG SCCACHE_VERSION=0.10.0
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"

FROM ubuntu:${UBUNTU_VERSION} AS sccache-builder
ARG SCCACHE_VERSION
ARG APT_INSTALL_COMMAND
LABEL maintainer="mmueller@gnuradio.org"

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i \
  's;# *\(deb .* jammy-updates.*\)$;\1;' \
  /etc/apt/sources.list
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
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2022-05-31

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         libad9361-0 \
         libasound2 \
         libboost-date-time1.74.0 \
         libboost-filesystem1.74.0 \
         libboost-program-options1.74.0 \
         libboost-thread1.74.0 \
         libfftw3-bin \
         libgmp10 \
         libgsl27 \
         libgtk-3-0 \
         libiio0 \
         libsoapysdr0.8 \
         soapysdr-tools \
         libjack-jackd2-0 \
         liblog4cpp5v5 \
         libpangocairo-1.0-0 \
         libportaudio2 \
         libqwt-qt5-6 \
         libsndfile1-dev \
         libsdl-image1.2 \
         libthrift-dev \
         libuhd4.1.0 \
         libusb-1.0-0 \
         libzmq5 \
         libpango-1.0-0 \
         gir1.2-gtk-3.0 \
         gir1.2-pango-1.0 \
         pkg-config \
         thrift-compiler \
         libvolk2-dev \
         --no-install-recommends \
    && apt-get clean

# Py3 deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         pybind11-dev \
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
         python3-sphinx \
         python3-sphinx-tabs \
         python3-breathe \
         python3-yaml \
         python3-zmq \
         python3-six \
         python3-pytest \
         --no-install-recommends \
    && apt-get clean

# Build deps
RUN mv /sbin/sysctl /sbin/sysctl.orig \
    && ln -sf /bin/true /sbin/sysctl \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       --no-install-recommends \
       build-essential \
       ccache \
       cmake \
       libad9361-dev \
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
       libfftw3-dev \
       libgmp-dev \
       libgsl0-dev \
       libgsm1-dev \
       libiio-dev \
       libsoapysdr-dev \
       libspdlog-dev \
       libfmt-dev \
       libqwt-qt5-dev \
       libqt5opengl5-dev \
       qtbase5-dev \
       libsdl1.2-dev \
       libuhd-dev \
       libusb-1.0-0-dev \
       libzmq3-dev \
       portaudio19-dev \
       pyqt5-dev-tools \
       doxygen \
       doxygen-latex \
    && rm -f /sbin/sysctl \
    && ln -s /usr/bin/ccache /usr/lib/ccache/cc \
    && ln -s /usr/bin/ccache /usr/lib/ccache/c++ \
    && mv /sbin/sysctl.orig /sbin/sysctl \
    && apt-get clean

# Testing deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
       xvfb \
       lcov \
       python3-scipy \
       clang-format \
       --no-install-recommends \
    && apt-get clean

# Install other dependencies (e.g. VOLK)
RUN apt-get -y install -q \
        git \
    ca-certificates \
    appstream-util \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
