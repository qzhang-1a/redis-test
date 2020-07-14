#!/bin/bash

portrange=($(seq 7001 1 7008))
for portrange in "${portrange[@]}"
do
        ./redis-cli -p 7000 CLUSTER MEET 127.0.0.1 $portrange
done
