ARG DEBIAN_VERSION=13

FROM debian:${DEBIAN_VERSION}-slim
LABEL maintainer="mmueller@gnuradio.org"
ENV security_updates_as_of=2026-11-23

ENV DEBIAN_FRONTEND=noninteractive 
ARG APT_INSTALL_COMMAND="apt-get -U install -qy --no-install-recommends"
ARG APT_CLEANER="rm /var/lib/apt/lists/*_*"

RUN ${APT_INSTALL_COMMAND} \
      bash \
      ca-certificates \
      clang-format-22 \
      git \
      zsh \
      && ${APT_CLEANER}

