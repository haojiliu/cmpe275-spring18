# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060 2818 60000 60010

RUN useradd hadoop
RUN usermod --password password hadoop


# Create a ssh key for later use
RUN ssh-keygen -f id_rsa -t rsa -N ''
RUN mkdir ~/.ssh
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys
RUN /etc/init.d/ssh start

# Hadoop
RUN wget http://mirrors.sonic.net/apache/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz
RUN tar -xzvf hadoop-3.0.0.tar.gz
RUN mv hadoop-3.0.0 /usr/local/hadoop


RUN echo -e "export HADOOP_HOME=/usr/local/hadoop\nexport PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin\n" >> ~/.profile
RUN source .profile

# hadoop configuration
RUN cd $HADOOP_HOME/etc/hadoop
COPY ./config/core-site.xml ./core-site.xml
COPY ./config/hdfs-site.xml ./hdfs-site.xml
COPY ./config/yarn-site.xml ./yarn-site.xml
COPY ./config/mapred-site.xml ./mapred-site.xml


# Add to ~/.profile
RUN echo -e "export HDFS_NAMENODE_USER=root\nexport HDFS_DATANODE_USER=root\nexport HDFS_SECONDARYNAMENODE_USER=root\nexport YARN_RESOURCEMANAGER_USER=root\nexport YARN_NODEMANAGER_USER=root\n"
RUN source ~/.profile

##################
# Hbase

RUN wget http://mirror.metrocast.net/apache/hbase/1.3.1/hbase-1.3.1-bin.tar.gz
RUN tar -zxvf hbase-1.3.1-bin.tar.gz
RUN mv hbase-1.3.1 /usr/local/hbase

# TODO: add these to ~/.profile
RUN echo -e "export HBASE_HOME=/usr/local/hbase\nexport PATH=$PATH:$HBASE_HOME/bin\n"
RUN source ~/.profile

# copy config files
RUN cd $HBASE_HOME/conf
COPY ./config/hbase-site.xml ./hbase-site.xml

###########

RUN start-dfs.sh
RUN start-yarn.sh
RUN start-hbase.sh

CMD ["/bin/bash"]
