#!/bin/bash

SWARM_CLUSTER_NAME=$1
STACK_NAME=$2

if [ "$SWARM_CLUSTER_NAME" = "" ]; then echo "You need to pass swarm cluster name" && echo " $0 <swarm_cluster_name> <stack_name>" && exit 1; fi
if [ "$STACK_NAME" = "" ]; then echo "You need to pass stack name" && echo " $0 <swarm_cluster_name> <stack_name>" && exit 1; fi


docker stack deploy --with-registry-auth -c $SWARM_CLUSTER_NAME/$STACK_NAME/compose.yml $STACK_NAME
