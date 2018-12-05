FROM ubuntu:bionic
MAINTAINER ldocky 
VOLUME ["/config"]

RUN     apt-get update
RUN	apt-get install -y software-properties-common 
RUN     add-apt-repository -y ppa:webupd8team/java && \
	apt-get update
RUN	apt-get install -y \
	wget \
	oracle-java8-installer \
	oracle-java8-set-default && \
	usermod -u 99 nobody && \
	usermod -g 100 nobody


RUN wget https://github.com/bwssytems/ha-bridge/releases/download/v5.2.2RC2/ha-bridge-5.2.2RC2.jar /src/ha-bridge-latest.jar

RUN chown -R nobody:users /config

ENTRYPOINT "java -jar /src/ha-bridge-latest.jar"
