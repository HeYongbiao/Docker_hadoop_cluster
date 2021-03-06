# 简介
    本项目实现在Docker中配置Hadoop中的HDFS（暂未支持MapReduce）。主要内容如下：<br>
    1、介绍部署HDFS集群条件<br>
    2、介绍部署HDFS集群的的详细步骤<br>
    3、介绍镜像文件DockerFile的制作工程<br>
# Precondition（前提）
    using Ubuntu 16.04.1 LTS
    使用较新版本的Ubuntu（只要能够startCluster.sh启动脚本即可，或者可以修改该脚本）
# How to use（用法）
###1. Download docker_hadoop_cluster image from https://hub.docker.com/<br>
```bash
docker pull docker pull bg2273337844/hadoop_cluster
```
###2. Download startCluster.sh from this repository<br>
###   从这个项目中下载工程，提取启动脚本startCluster.sh<br>
###3. Run the bash script<br>
###   执行启动脚本<br>
```bash
bash startCluster.sh
```
the output will be like this(输出结果):<br>
`eee1d3aed774466006dc85e1affd8c4c2497d09ed3e62b4f8ea94ab9064d2f07`<br>
`server1 is started`<br>
`6acf6cb35af5f43d3395f1964c808f02a75a82b12075671f5be1346c0efdc26a`<br>
`server2 is started`<br>
`fd5a6b84a45c6f01d648302b8ae65d2999678a029c75ca27d59e51c26abb0f44`<br>
`server3 is started`<br>
`719933d428fb711b8798bc3f3fa70669186ac4b4eeb0d922d79cd94f90e3e026`<br>
`server4 is started`<br>
and the cli will get into `server1`
ps : `server1` is `NameNode`, while `server2`, `server3`, `server3` are `DataNode`<br>
其中`server1`是`NameNode`,`server2`、`server3`、`server4`均为`DataNode`<br>
###4. Check whether the containers run normally
###   检查容器运行是否正常
use another command-line interface connecting to the original server，run the following script:<br>
```bash
docker ps
```
the output will be like this（输出结果）:<br>
`CONTAINER ID  IMAGE                             COMMAND                   CREATED     STATUS              PORTS           NAMES`<br>
`291c007f1fee  bg2273337844/hadoop_cluster:3.0   "/bin/sh -c 'sh -c \"s"   3 seconds  2 seconds  50070/tcp, 50090/tcp     server4`<br>
`a3b6ca933afb  bg2273337844/hadoop_cluster:3.0   "/bin/sh -c 'sh -c \"s"   4 seconds  3 seconds  50070/tcp, 50090/tcp     server3`<br>
`67de63690033  bg2273337844/hadoop_cluster:3.0   "/bin/sh -c 'sh -c \"s"   5 seconds  4 seconds  50070/tcp, 50090/tcp     server2`<br>
`d97c445bed5b  bg2273337844/hadoop_cluster:3.0   "/bin/sh -c 'sh -c \"s"   6 seconds  5 seconds  0.0.0.0:8080->50070/tcp 0.0.0.0:8080->50070/tcp server1`<br>
if there are there containers named `server1`,`server2`,`server3` and `server4`<br>
you set up a multi-node Hadoop installation in right way<br>
###5.Start hadoop hdfs<br>
###  在server1启动HDFS<br>
go back to `server1`, run the following script:<br>
```bash
start-dfs.sh
```
the output will be like this:<br>
`Starting namenodes on [server1]:`<br>
`server1: Warning: Permanently added 'server1,172.18.0.2' (RSA) to the list of known hosts.`<br>
`server1: starting namenode, logging to /development/hadoop-2.7.3/logs/hadoop-root-namenode-server1.out`<br>
`server2: Warning: Permanently added 'server2,172.18.0.3' (RSA) to the list of known hosts.`<br>
`server4: Warning: Permanently added 'server4,172.18.0.5' (RSA) to the list of known hosts.`<br>
`server3: Warning: Permanently added 'server3,172.18.0.4' (RSA) to the list of known hosts.`<br>
`server4: starting datanode, logging to /development/hadoop-2.7.3/logs/hadoop-root-datanode-server4.out`<br>
`server3: starting datanode, logging to /development/hadoop-2.7.3/logs/hadoop-root-datanode-server3.out`<br>
`server2: starting datanode, logging to /development/hadoop-2.7.3/logs/hadoop-root-datanode-server2.out`<br>
`Starting secondary namenodes [server1]`<br>
`server1: Warning: Permanently added 'server1,172.18.0.2' (RSA) to the list of known hosts.`<br>
`server1: starting secondarynamenode, logging to /development/hadoop-2.7.3/logs/hadoop-root-secondarynamenode-server1.out`<br>
# How to build this images
# 如何制作此镜像
    。。。
