#!/bin/sh
slots=($(seq 0 1 5460))
slotsstring=$( IFS=$' '; echo "${slots[*]}" )
./redis-cli -p 7000 cluster addslots $slotsstring

slots=($(seq 5461 1 10922))
slotsstring=$( IFS=$' '; echo "${slots[*]}" )
./redis-cli -p 7003 cluster addslots $slotsstring

slots=($(seq 10923 1 16383))
slotsstring=$( IFS=$' '; echo "${slots[*]}" )
./redis-cli -p 7006 cluster addslots $slotsstring
