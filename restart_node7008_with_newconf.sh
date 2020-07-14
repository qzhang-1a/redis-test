#!/bin/bash

# shutdown node 7008
kill `ps ux | grep redis-server | grep 7008 | awk '{print $2}'`
sleep 1;

# clean the node.conf
cd 7008
rm dump.rdb node.conf

# restart node 7008, will have a new node id
../redis-server ./redis.conf.7008 &
cd ..
sleep 3;

# Join the 2nd cluster and be a replica of 7015
./redis-cli -p 7015 CLUSTER MEET 127.0.0.1 7008
sleep 2;

ID=`./redis-cli -p 7008 cluster nodes | grep 7015 | awk '{print $1}'`
./redis-cli -p 7008 cluster replicate $ID
sleep 3;