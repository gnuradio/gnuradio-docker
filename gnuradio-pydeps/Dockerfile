FROM gnuradio/gnuradio-cppdeps
MAINTAINER jcorgan@gnuradio.org

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         python-cheetah \
         python-dev \
         python-gtk2 \
         python-lxml \
         python-numpy \
         python-opengl \
         python-qt4 \
         python-wxgtk3.0 \
         python-zmq \
         --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
