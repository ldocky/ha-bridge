FROM ubuntu:focal
MAINTAINER ldocky 
VOLUME ["/config"]

ENV     DEBIAN_FRONTEND=noninteractive
RUN     apt-get update
RUN	apt-get install -y software-properties-common 
RUN	apt-get install -y \
	wget \
	openjdk-11-jre-headless \
	usermod -u 99 nobody && \
	usermod -g 100 nobody

RUN mkdir /src/
WORKDIR /src/
RUN wget https://github.com/bwssytems/ha-bridge/releases/download/v5.3.1RC1/ha-bridge-5.3.1RC1.jar -O /src/latest.jar

RUN chown -R nobody:users /config

ENTRYPOINT ["java", "-jar", "-Dconfig.file=/config/habridge.config", "/src/latest.jar"]
