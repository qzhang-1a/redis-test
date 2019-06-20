# redis-test
## Reproducer of redis cluster fusing issue

This issue is detected when using [Redis-Operator](https://github.com/AmadeusITGroup/Redis-Operator). 

*Scenario:*
1. A pod "foo" of redis cluster A is rescheduled or deleted for some reason 
2. The IP of pod "foo" still remain in the cluster A. Redis-Operator will send command "cluster forget" to all remaining nodes in order to remove "foo" from the cluster. However this operation could fail for some reaon, for instance a temporary network glitch 
3. Shortly after, Openshift assigns the IP of this deleted pod "foo" to a newly created pod "bar" of cluster B 
4. Members of cluster A are still trying to reach pod "bar" because of the same IP.
5. Boom! Two clusters are joined by accident.  
  
\
*Steps to reproduce this issue on a local environment:*

```sh
# Start 2 clusters with respectively 9 nodes and 8 nodes
# Cluster 1 will use port 7000 - 7008 (7000, 7003, 7006 are masters)
# Cluster 2 will use port 7009 - 7016 (7009, 7012, 7015 are masters)
./build_test_env.sh

# In other shell, monitor the cluster topologies of cluster 1 & 2
# For cluster 1
watch "./redis-cli -p 7000 cluster nodes"
# For cluster 2
watch "./redis-cli -p 7009 cluster nodes"


# Shut down node 7008 of cluster 1 and create a new node for cluster 2 using the same port
./restart_node7008_with_newconf.sh

# Now we can see that both cluster topologies contains 17 pods !

# To shut down all servers and clean the test environement
./clean_test.sh
