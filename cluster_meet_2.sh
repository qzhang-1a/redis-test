#!/bin/sh

portrange=($(seq 7010 1 7016))
for portrange in "${portrange[@]}"
do
        ./redis-cli -p 7009 CLUSTER MEET 127.0.0.1 $portrange
done
