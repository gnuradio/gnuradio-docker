ARG dist=ubuntu:focal
FROM $dist
ARG gr_version=3.10.1
RUN apt update && apt install -y software-properties-common
RUN add-apt-repository ppa:gnuradio/gnuradio-releases && \
	apt update && \
	DEBIAN_FRONTEND="noninteractive" apt install -y \
	clang-format \
	cmake \
	doxygen \
	gdb \
	gir1.2-gtk-3.0 \
	git \
	gnuradio=$gr_version* \
	gnuradio-dev=$gr_version* \
	graphviz \
	libspdlog-dev \
	pkg-config \
	python3-pip \
	swig
RUN pip3 install pygccxml
# Configure the paths required to run GR over python2 and python3
RUN if command -v python2 ; then \
	PYSITEDIR=$(python2 -m site --user-site) && \
	PYLIBDIR=$(python2 -c "from distutils import sysconfig; \
	print(sysconfig.get_python_lib(plat_specific=False, prefix='/usr/local'))") && \
	mkdir -p "$PYSITEDIR" && \
	echo "$PYLIBDIR" > "$PYSITEDIR/gnuradio.pth" ; fi
RUN PYSITEDIR=$(python3 -m site --user-site) && \
	PYLIBDIR=$(python3 -c "from distutils import sysconfig; \
	print(sysconfig.get_python_lib(plat_specific=False, prefix='/usr/local'))") && \
	mkdir -p "$PYSITEDIR" && \
	echo "$PYLIBDIR" > "$PYSITEDIR/gnuradio.pth"
