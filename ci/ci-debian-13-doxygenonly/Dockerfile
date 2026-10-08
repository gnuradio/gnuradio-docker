ARG DEBIAN_VERSION=13

FROM debian:${DEBIAN_VERSION}-slim
LABEL maintainer="mmueller@gnuradio.org"

ENV DEBIAN_FRONTEND=noninteractive 
ARG APT_INSTALL_COMMAND="apt-get -U install -qy --no-install-recommends"
ARG APT_CLEANER="rm /var/lib/apt/lists/*_*"

RUN ${APT_INSTALL_COMMAND} \
        ca-certificates \
        cmake \
        doxygen \
        doxygen-latex \
        ninja-build \
        git \
        # Things needed to make cmake succeed:
        g++ \
        gcc \
        libboost-date-time-dev \
        libboost-dev \
        libboost-filesystem-dev \
        libboost-program-options-dev \
        libboost-regex-dev \
        libboost-test-dev \
        libboost-thread-dev \
        && ${APT_CLEANER}
RUN ${APT_INSTALL_COMMAND} \
        # for archive upload
        squashfs-tools \
        && ${APT_CLEANER}
