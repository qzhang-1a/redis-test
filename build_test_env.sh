#!/bin/sh

./create_conf.sh
./run_servers.sh
sleep 5;
./cluster_meet_1.sh
./cluster_meet_2.sh
sleep 5;
./assign_roles_cluster1.sh
./assign_roles_cluster2.sh
sleep 5;
./addslots_to_cluster1.sh
./addslots_to_cluster2.sh

echo "End of build"