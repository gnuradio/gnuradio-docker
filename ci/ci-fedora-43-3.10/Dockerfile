# --- VERSIONS ---
ARG FEDORA_VERSION=43
# Fedora 43 ships sufficiently recent sccache
# ARG SCCACHE_VERSION=0.10.0
ARG LIBAD9361_TAG=v0.3


ARG DNF_COMMAND="dnf --setopt=install_weak_deps=False -q"


# ---- build libad9361
FROM fedora:${FEDORA_VERSION} AS libad9361-builder
ARG LIBAD9361_TAG

ARG DNF_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
RUN ${DNF_COMMAND} install --refresh -y \
        libiio-devel \
        cmake \
        git \
        g++ \
        cpio \
        && ${DNF_COMMAND} clean all
# Install libad9361
RUN mkdir -p /src/build \
        && git clone \
        --branch ${LIBAD9361_TAG} \
        --depth 1 \
        https://github.com/analogdevicesinc/libad9361-iio \
        /src/libad9361 \
        && cmake \
        -B /src/build \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        /src/libad9361/ \
        && cmake --build /src/build \
        # wish we could properly install in a prefix, but ADI's CMake
        # hardcodes things, so cmake --install … --prefix /target doesn't
        # work.
        && cmake --install /src/build \
        && cpio -o < /src/build/install_manifest.txt > /target.cpio


# ---- MAIN CONTAINER ----
FROM fedora:${FEDORA_VERSION}

ARG DNF_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
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
        cpio \
        # For build artifact caching 
        sccache \
        && ${DNF_COMMAND} clean all
# Copy over libad9361
COPY --from=libad9361-builder /target.cpio /libad9361-iio.cpio
RUN cpio --extract \
        --unconditional \
        --make-directories \
        --absolute-filenames \
        < /libad9361-iio.cpio \
        && rm /libad9361-iio.cpio

