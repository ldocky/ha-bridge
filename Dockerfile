FROM ubuntu:bionic
MAINTAINER ldocky 
VOLUME ["/config"]

ENV     DEBIAN_FRONTEND=noninteractive
RUN     apt-get update
RUN	apt-get install -y software-properties-common 
RUN     add-apt-repository -y ppa:webupd8team/java && \
	apt-get update
RUN     echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN	apt-get install -y \
	wget \
	oracle-java8-installer \
	oracle-java8-set-default && \
	usermod -u 99 nobody && \
	usermod -g 100 nobody

RUN mkdir /src/
WORKDIR /src/
RUN wget https://github.com/bwssytems/ha-bridge/releases/download/v5.2.2RC2/ha-bridge-5.2.2RC2.jar -O /src/latest.jar

RUN chown -R nobody:users /config

ENTRYPOINT "tail -F n0 /dev/null"
