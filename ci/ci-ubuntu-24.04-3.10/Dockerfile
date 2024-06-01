FROM ubuntu:24.04
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2024-05-27

# Prepare distribution
RUN sed -i 's/Types: deb/& deb-src/' /etc/apt/sources.list.d/ubuntu.sources \
    && apt-get update -q \
    && apt-get -y upgrade \
    && apt-get clean && apt-get autoclean

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -qy --no-install-recommends \
  appstream-util \
  ca-certificates \
  ccache \
  clang-format \
  cmake \
  git \
  lcov \
  pkg-config \
  xvfb \
  && apt-get build-dep -qy gnuradio \
  && apt-get clean && apt-get autoclean
