FROM centos:7.6.1810
MAINTAINER Martin Braun <martin@gnuradio.org>

ENV security_updates_as_of 2021-01-06

RUN yum install epel-release -y -q
RUN yum --enablerepo=epel check-update -y; yum install -y \
# Build
        make \
        gcc \
        gcc-c++ \
        python36-pip \
        python-pip \
        xz

# CPP deps
RUN yum install -y \
        boost-devel \
        log4cpp-devel \
        cppzmq-devel \
        libunwind-devel \
        git \
# Math libraries
        fftw-devel \
        gsl-devel \
        gmp-devel \
# Documentation
        doxygen \
        graphviz \
# Audio, SDL
        SDL-devel \
        alsa-lib-devel \
        portaudio-devel \
        jack-audio-connection-kit-devel \
        libsndfile-devel \
# HW drivers
        uhd-devel \
## Vocoder libraries
        codec2-devel \
        gsm-devel \
        && yum clean all

# Python deps
RUN yum install -y \
        python36-devel \
        python36-pybind11 \
        python36-numpy \
        python36-scipy \
        python36-zmq \
        python36-thrift \
        python36-pytest \
        python36-PyYAML \
        python36-six \
        python36-sphinx \
        python36-click \
        swig3 \
# Python 2
        python-devel \
        python-lxml \
        python-cheetah \
        pygtk2-devel \
        python-six \
        python2-sphinx \
        python2-click \
# GUI libraries
        xdg-utils \
        qt5-qtbase-devel \
        qwt-qt5-devel \
        qwt-devel \
        python36-PyQt5 \
        python36-qt5-devel \
# XML Parsing / GRC
        desktop-file-utils \
        python36-click \
        python36-click-plugins \
# GRC/next
        python36-pyyaml \
        python36-lxml \
        python36-gobject \
	gtk3 \
        python36-cairo \
        pango \
# Clean up
        && yum clean all

# Install exact minimum versions
RUN pip3 install cmake==3.8.2
RUN pip3 install mako==0.9.1
RUN pip install mako==0.9.1
RUN pip3 install click-plugins
RUN pip install click-plugins

# Thrift
RUN yum install -y libtool byacc flex && yum clean all
RUN mkdir /src && cd /src \
    && git clone https://github.com/apache/thrift.git --branch 0.9.2 --depth 1 \
    && cd thrift \
    && ./bootstrap.sh \
    && ./configure --with-c_glib --with-cpp --with-libevent --with-python --without-csharp --without-d --without-erlang --without-go --without-haskell --without-java --without-lua --without-nodejs --without-perl --without-php --without-ruby --without-zlib --without-qt4 --without-qt5 --disable-tests --disable-tutorial --prefix=/usr \
    && make -j4 install
RUN cd /src/thrift \
    && PYTHON=/usr/bin/python3 ./configure --with-c_glib --with-cpp --with-libevent --with-python --without-csharp --without-d --without-erlang --without-go --without-haskell --without-java --without-lua --without-nodejs --without-perl --without-php --without-ruby --without-zlib --without-qt4 --without-qt5 --disable-tests --disable-tutorial --prefix=/usr \
    && make -j4 install

# Tactical patch for QWT
RUN sed -i 's/QT_STATIC_CONST //g' /usr/include/qwt/qwt_transform.h

# Install VOLK. We could use the submodule, but that's just an unnecessary build step.
RUN    mkdir -p /src/volk && mkdir -p /src/build && \
        cd /src && \
        curl -Lo volk.tar.gz https://github.com/gnuradio/volk/archive/v2.0.0.tar.gz && \
        tar xzf volk.tar.gz -C volk --strip-components=1 && \
        cd build && \
        cmake -DCMAKE_BUILD_TYPE=Release -S ../volk/ && \
        cmake --build . && \
        cmake --build . --target install

RUN rm -r /src

# TODO: Python 2.7.6 needs to be installed from source.
# TODO: Thrift is not yet being detected. thrift-devel from yum is too old, but my build from source doesn't get detected.
