FROM gnuradio/gnuradio-builddeps
MAINTAINER Johnathan Corgan <jcorgan@gnuradio.org>

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       --no-install-recommends \
       doxygen-latex \
       python-pygraphviz \
       python-sphinx \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash user
WORKDIR /home/user
USER user
ADD user /home/user
ADD build.sh /home/user/
ENV HOME /home/user

CMD ["/bin/bash", "--login", "-c", "/home/user/build.sh"]
