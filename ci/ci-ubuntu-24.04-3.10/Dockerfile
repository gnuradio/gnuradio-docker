ARG UBUNTU_VERSION=24.04
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
  && apt-get build-dep -qy gnuradio \
  && apt-get clean && apt-get autoclean

# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
