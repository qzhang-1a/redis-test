#!/bin/sh

portrange=($(seq 7000 1 7016))
for portrange in "${portrange[@]}"
do
        rm -rf $portrange
done

