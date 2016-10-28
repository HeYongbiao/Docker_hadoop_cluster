#!/bin/bash

hadoop=`docker network ls | grep hadoop | wc -l`
if [[ $hadoop -eq 0 ]]; then
	sudo docker network create --driver=bridge hadoop
fi
sudo docker rm -f server1 &> /dev/null
sudo docker run -itd --net=hadoop -p 8080:50070 -p 8081:50090 --name=server1 --hostname=server1 bg2273337844/hadoop_cluster:3.0
echo server1 is started

for((i=2; i<=4; i++))
do
	sudo docker rm -f server$i &> /dev/null
	sudo docker run -itd --net=hadoop --name=server$i --hostname=server$i bg2273337844/hadoop_cluster:3.0
	echo server$i is started
done
sudo docker exec -it server1 /bin/bash
