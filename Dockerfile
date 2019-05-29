FROM ubuntu:bionic
MAINTAINER ldocky 
VOLUME ["/config"]

ENV     DEBIAN_FRONTEND=noninteractive
RUN     apt-get update
RUN	apt-get install -y software-properties-common 
RUN     add-apt-repository ppa:linuxuprising/java && \
	apt-get update
RUN     echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN	apt-get install -y \
	wget \
	oracle-java10-installer \
	oracle-java10-set-default && \
	usermod -u 99 nobody && \
	usermod -g 100 nobody

RUN mkdir /src/
WORKDIR /src/
RUN wget https://github.com/bwssytems/ha-bridge/releases/download/v5.2.2/ha-bridge-5.2.2.jar -O /src/latest.jar

RUN chown -R nobody:users /config

ENTRYPOINT ["java", "-jar", "-Dconfig.file=/config/habridge.config", "/src/latest.jar"]
