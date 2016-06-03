FROM gnuradio/gnuradio-cppdeps
MAINTAINER jcorgan@gnuradio.org

ENV PREFIX /opt/gnuradio
ADD prefix/ /opt/gnuradio/

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user
ADD user /home/user
ENV HOME /home/user

CMD ["/bin/bash", "--login"]
