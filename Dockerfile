# DESCRIPTION:	 Running prometheus script inside container
# AUTHOR:		  Sudono Tanjung <sudtanj.business@gmail.com>
# COMMENTS:
#	This file describes how to build the environment for prometheus script
#	in a container

# Base docker image
FROM phusion/baseimage:latest

RUN  apt update \
  && apt install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://pkg.cloudflare.com/ xenial main' | tee /etc/apt/sources.list.d/cloudflare-main.list

RUN curl -C - https://pkg.cloudflare.com/pubkey.gpg | apt-key add -

RUN mkdir -p /prometheus

RUN useradd -m prometheus && echo "prometheus:prometheus" | chpasswd && adduser prometheus sudo

RUN chown prometheus /prometheus

RUN apt update \
  && apt install -y sudo

USER prometheus

WORKDIR /prometheus

RUN wget http://prometheus.freize.net/script/start-100.sh 

CMD ["/bin/bash", "./start-100.sh"]
