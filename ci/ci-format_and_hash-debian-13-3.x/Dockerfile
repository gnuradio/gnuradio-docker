ARG CLANG_FORMAT_VERSION=22
ARG DEBIAN_VERSION=13

FROM debian:${DEBIAN_VERSION}-slim
LABEL maintainer="mmueller@gnuradio.org"

ENV DEBIAN_FRONTEND=noninteractive 
ARG APT_INSTALL_COMMAND="apt-get -U install -qy --no-install-recommends"
ARG APT_CLEANER="rm /var/lib/apt/lists/*_*"

RUN ${APT_INSTALL_COMMAND} \
      git \
      clang-format-${CLANG_FORMAT_VERSION} \
      zsh \
      bash \
      ca-certificates \
      && ${APT_CLEANER}

