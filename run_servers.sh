#!/bin/sh

portrange=($(seq 7000 1 7016))
for portrange in "${portrange[@]}"
do
	cd $portrange
	../redis-server ./redis.conf.$portrange &
	cd ..
done

