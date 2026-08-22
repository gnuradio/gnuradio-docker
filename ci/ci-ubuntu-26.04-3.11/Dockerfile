ARG UBUNTU_VERSION=26.04
ARG SCCACHE_VERSION=0.10.0
ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"


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
LABEL maintainer="martin@gnuradio.org"
ENV security_updates_as_of=2026-01-31

ENV DEBIAN_FRONTEND=noninteractive

# Prepare distribution
RUN sed -i 's/Types: deb/& deb-src/' /etc/apt/sources.list.d/ubuntu.sources \
  && apt-get update -q \
  && apt-get -y upgrade \
  && apt-get clean && apt-get autoclean

RUN \
  ${APT_INSTALL_COMMAND} \
  appstream-util \
  ca-certificates \
  ccache \
  clang-format \
  cmake \
  git \
  lcov \
  pkg-config \
  xvfb \
  # for bundling up results
  squashfs-tools \
  && apt-get clean && apt-get autoclean

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade \
    && apt-get clean && apt-get autoclean

# Build deps
RUN ${APT_INSTALL_COMMAND} \
  cmake \
  g++ \
  cppzmq-dev \
  debhelper-compat \
  dh-python \
  dpkg-dev \
  gir1.2-gtk-3.0 \
  gir1.2-pango-1.0 \
  graphviz \
  libad9361-dev \
  libasound2-dev \
  libboost-date-time-dev \
  libboost-dev \
  libboost-program-options-dev \
  libboost-regex-dev \
  libboost-test-dev \
  libboost-thread-dev \
  libcodec2-dev \
  libcppunit-dev \
  libfftw3-dev \
  libfontconfig-dev \
  libgmp-dev \
  libgsl-dev \
  libgsm1-dev \
  libiio-dev \
  libjack-jackd2-dev \
  libjs-mathjax \
  libpulse-dev \
  libqt6opengl6-dev \
  libqt6svg6-dev \
  libsdl1.2-dev \
  libsndfile1-dev \
  libsoapysdr-dev \
  libspdlog-dev \
  libthrift-dev \
  libuhd-dev \
  libunwind-dev \
  libusb-1.0-0-dev \
  libvolk-dev \
  libxi-dev \
  libxrender-dev \
  ninja-build \
  pkgconf \
  portaudio19-dev \
  pybind11-dev \
  thrift-compiler \
  xauth \
  xmlto \
  && apt-get clean && apt-get autoclean

# Py3 deps
RUN ${APT_INSTALL_COMMAND} \
  python3-click \
  python3-dev \
  python3-gi \
  python3-gi-cairo \
  python3-jsonschema \
  python3-lxml \
  python3-mako \
  python3-numpy-dev \
  python3-opengl \
  python3-packaging \
  python3-pygccxml \
  python3-pyqt6 \
  python3-pytest \
  python3-schema \
  python3-scipy \
  python3-thrift \
  python3-yaml \
  python3-zmq \
  pyqt6-dev-tools \
  python3-pyqt6.qtsvg \
  && apt-get clean && apt-get autoclean


# Install Qwt-Qt6 (from Debian Testing)
RUN ${APT_INSTALL_COMMAND} wget && apt-get clean && apt-get autoclean

RUN wget http://ftp.de.debian.org/debian/pool/main/q/qwt/libqwt-headers_6.3.0-3_amd64.deb && \
  wget http://ftp.de.debian.org/debian/pool/main/q/qwt/libqwt-qt6-6.3_6.3.0-3_amd64.deb && \
  wget http://ftp.de.debian.org/debian/pool/main/q/qwt/libqwt-qt6-dev_6.3.0-3_amd64.deb

RUN dpkg -i libqwt-headers_6.3.0-3_amd64.deb && \
  dpkg -i libqwt-qt6-6.3_6.3.0-3_amd64.deb && \
  dpkg -i libqwt-qt6-dev_6.3.0-3_amd64.deb

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
