FROM fedora:41
LABEL maintainer="mmueller@gnuradio.org"

ENV security_updates_as_of 2025-01-23
ARG LIBAD9361_TAG=v0.3
ARG DNF_COMMAND="dnf --setopt=install_weak_deps=False"

# Make sure we don't try to use XCB, which seems to be very b0rked at this point
ENV QT_QPA_PLATFORM=offscreen

# Build deps
RUN ${DNF_COMMAND} build-dep --refresh -y gnuradio \
        && ${DNF_COMMAND} install -y \
        # gr-iio
        libiio-devel \
        # JSON/YAML runtime config GRC blocks
        python3-jsonschema \
        # doxygen build (we should fix that with fedora's packaging)
        texlive-newunicodechar \
        && ${DNF_COMMAND} clean all
# Specific tools not needed for the default build, but things we want to do in CI:
RUN ${DNF_COMMAND} install --refresh -y \
        clang \
        clang-tools-extra \
        ninja-build \
        # For testing metainfo files
        libappstream-glib \
        # Install zsh for hash checker CI
        zsh \
        # For hash checking and libad9361 building
        git \
        # For bundling up results
        squashfs-tools \
        && ${DNF_COMMAND} clean all
# Install libad9361
RUN mkdir -p /src/build \
        && git clone https://github.com/analogdevicesinc/libad9361-iio /src/libad9361 --branch ${LIBAD9361_TAG} --depth 1 \
        && cd /src/build && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../libad9361/ \
        && make && make install \
        && cd / && rm -rf /src

RUN true
