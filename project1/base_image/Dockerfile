# Author: Haoji Liu
LABEL maintainer="divid86391@hotmail.com"
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install man git rsync build-essential python-dev python-pip curl vim ant openjdk-8-jdk openjdk-8-jre net-tools ssh openssh-server zip unzip sudo wget

# TODO: add these to ~/.profile
RUN echo -e "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64\nexport PATH=$PATH:$JAVA_HOME/bin\n" >> ~/.profile
RUN source ~/.profile
