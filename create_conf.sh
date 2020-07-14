#!/bin/bash

portrange=($(seq 7000 1 7016))
for portrange in "${portrange[@]}"
do
	mkdir $portrange
	cd $portrange
	cp ../redis.conf.tmpl redis.conf.$portrange
	echo "port $portrange" >> redis.conf.$portrange
	cd ..
done
