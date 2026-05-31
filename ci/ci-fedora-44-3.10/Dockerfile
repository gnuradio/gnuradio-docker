# --- VERSIONS ---
ARG FEDORA_VERSION=44
# Fedora >=43 has sccache, but none with S3 storage support
ARG SCCACHE_VERSION=0.15.0


ARG DNF_COMMAND="dnf --setopt=install_weak_deps=False -q"
# ---- sccache takes a while to build (it's rust…) and
#      quite a bit of space (it's cargo), so:
# avoid rebuilding if version hasn't changed
FROM fedora:${FEDORA_VERSION} AS sccache-builder
ARG SCCACHE_VERSION

ARG DNF_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
RUN ${DNF_COMMAND} install --refresh -y \
        cargo \
        openssl-devel \
        && ${DNF_COMMAND} clean all

RUN cargo install \
        --locked \
        --quiet \
        --target-dir /build \
        --root /target \
        sccache@${SCCACHE_VERSION} \
        && rm -rf /build


# ---- MAIN CONTAINER ----
FROM fedora:${FEDORA_VERSION}

ARG DNF_COMMAND
LABEL maintainer="mmueller@gnuradio.org"
# Make sure we don't try to use XCB, which seems to be very b0rked at this point
ENV QT_QPA_PLATFORM=offscreen

# Build deps
RUN ${DNF_COMMAND} install --refresh -y \
				SDL-devel \
				SoapySDR-devel \
				alsa-lib-devel \
				boost-devel \
				cmake \
				codec2-devel \
				cppzmq-devel \
				desktop-file-utils \
				doxygen \
				fftw-devel \
				findutils \
				gcc-c++ \
				gmp-devel \
				gobject-introspection \
				graphviz \
				gsl-devel \
				gsm-devel \
				gtk3-devel \
				jack-audio-connection-kit-devel \
				libad9361-iio-devel \
				libiio-devel \
				libsndfile-devel \
				portaudio-devel \
				pybind11-devel \
				python3-cairo \
				python3-click \
				python3-devel \
				python3-gobject \
				python3-jsonschema \
				python3-lxml \
				python3-mako \
				python3-numpy \
				python3-pyyaml \
				python3-qt5-devel \
				python3-scipy \
				python3-thrift \
				python3-zmq \
				qwt-qt5-devel \
				spdlog-devel \
				'tex(latex)' \
				thrift \
				uhd-devel \
				volk-devel \
				xdg-utils \
				xmlto \
				zeromq-devel \
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
        && ${DNF_COMMAND} clean all
# Copy over sccache
COPY --from=sccache-builder /target/bin/sccache /usr/bin/sccache
