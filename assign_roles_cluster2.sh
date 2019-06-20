#!/bin/sh
masterPorts=(7009 7012 7015)
for masterPorts in "${masterPorts[@]}"
do
	ID=`./redis-cli -p $masterPorts cluster nodes | grep $masterPorts  | awk '{print $1}'`
        ./redis-cli -p $((masterPorts+1)) cluster replicate $ID
	./redis-cli -p $((masterPorts+2)) cluster replicate $ID
done

