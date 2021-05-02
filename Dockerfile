FROM debian:buster
MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

# Install Compiler stuff
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get -y install build-essential
RUN apt-get -y install libsndfile1-dev fftw3-dev tcl sqlite3 libsqlite3-tcl
RUN apt-get -y install git



#
# Install VNC stuff
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install xvfb x11vnc xdotool wget tar supervisor net-tools fluxbox
RUN apt-get install -y gnupg2
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*
# cf. https://wiki.winehq.org/Debian
ENV DISPLAY :0


# Install noVNC stuff
WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.1.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
RUN wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.9.0 /root/novnc/utils/websockify



# Install Audio stuff
RUN apt-get -y install socat
RUN apt-get -y install pulseaudio pavucontrol
#RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*

ADD startup.sh /bin

# Build the software
ADD ./ /src
WORKDIR /src
RUN ./configure
RUN make 
RUN make install


EXPOSE 8080

ENTRYPOINT ["startup.sh"]
CMD ["/usr/bin/supervisord"]
