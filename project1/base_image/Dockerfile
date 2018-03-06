# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM ubuntu:16.04

# Update OS
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install python3-pip man git rsync build-essential python-dev python-pip curl vim ant openjdk-8-jdk openjdk-8-jre net-tools ssh openssh-server zip unzip nginx supervisor sudo wget postgresql postgresql-contrib
RUN echo -e "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64\nexport PATH=$PATH:$JAVA_HOME/bin\n" >> ~/.profile

ADD ./config /srv/config
RUN pip install --upgrade pip
RUN pip3 install --upgrade pip
RUN pip install -r /srv/config/requirements.txt
RUN pip3 install -r /srv/config/requirements-python3.txt

RUN echo "deb http://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/ ./" >> /etc/apt/sources.list
RUN wget https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/Release.key -O- | sudo apt-key add
RUN apt-get install libzmq3-dev
