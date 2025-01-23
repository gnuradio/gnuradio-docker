FROM ubuntu:24.04
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2025-01-24

ARG APT_INSTALL_COMMAND="apt-get install -qy --no-install-recommends"
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
  && apt-get build-dep -qy gnuradio \
  && apt-get clean && apt-get autoclean
