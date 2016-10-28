FROM	centos:6.8
MAINTAINER	Yongbiao He From Sun Yat-sen University
USER	root

######	install basic tools	#####
RUN     yum clean all
RUN	yum install -y curl which tar sudo openssh-server openssh-clients rsync

######	update base library	#####
RUN	yum update -y libselinux

######	create workspace dir	#####
RUN	mkdir -p /development/tar.gz
RUN	mkdir -p /tmp/docker
RUN	mkdir -p /development/jdk_8u101
RUN	mkdir -p /development/hadoop-2.7.3
RUN	mkdir -p /development/data/hadoop/tmp

######	copy configuration file	#####
COPY	docker/* /tmp/docker/

######	config	ssh		#####
RUN	service sshd start
RUN	ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN	cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN	mv /tmp/docker/sshConfig /root/.ssh/config

######	config jdk		#####
COPY	tar.gz/jdk-8u101-linux-x64.tar.gz /development/tar.gz
RUN	tar -zxf /development/tar.gz/jdk-8u101-linux-x64.tar.gz -C /development/jdk_8u101 --strip-components 1
ENV	JAVA_HOME /development/jdk_8u101
ENV	PATH $PATH:$JAVA_HOME/bin

######	config hadoop		#####
COPY	tar.gz/hadoop-2.7.3.tar.gz /development/tar.gz
RUN	tar -zxf /development/tar.gz/hadoop-2.7.3.tar.gz -C /development/hadoop-2.7.3 --strip-components 1
ENV	HADOOP_HOME /development/hadoop-2.7.3
ENV	PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
RUN	sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/development/jdk_8u101\nexport HADOOP_HOME=/development/hadoop-2.7.3\n:' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
######	config hadoop cluster	#####
RUN	mv /tmp/docker/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN	mv /tmp/docker/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
RUN	mv /tmp/docker/masters $HADOOP_HOME/etc/hadoop/masters
RUN	mv /tmp/docker/slaves $HADOOP_HOME/etc/hadoop/slaves
######	format namenode 	#####
RUN	$HADOOP_HOME/bin/hdfs namenode -format

######	config hbase		#####

######	hdfs ports		#####
EXPOSE	50070 50090

######	initialize command	#####
CMD	sh -c "service sshd start; /bin/bash"