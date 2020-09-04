FROM ubuntu:18.04
MAINTAINER Jake Massoth jake@massoth.tech

ENV TZ=Europe/Amsterdam
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

COPY . /usr/src/anp
WORKDIR /usr/src/anp

RUN apt-get -y update && \
    apt-get install -y build-essential cmake libcap-dev sudo iptables iproute2 arping && \
    cmake . && \
    make && \
    make install

ENTRYPOINT bin/sh-make-tun-dev.sh; bin/sh-disable-ipv6.sh; bin/sh-setup-fwd.sh anp_bridge; /bin/bash