FROM ubuntu:bionic
MAINTAINER ldocky 
VOLUME ["/config"]

RUN add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
	apt-get install -y \
	wget \
	oracle-java8-installer \
	oracle-java8-set-default && \
	usermod -u 99 nobody && \
	usermod -g 100 nobody && \


wget https://github.com/bwssytems/ha-bridge/releases/download/v5.2.2RC2/ha-bridge-5.2.2RC2.jar /src/ha-bridge-latest.jar

chown -R nobody:users /config

ENTRYPOINT "java -jar /src/ha-bridge-latest.jar"
