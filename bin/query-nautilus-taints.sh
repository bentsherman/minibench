#!/bin/bash
# Query the list of taints for each node in Nautilus.

NODES=`kubectl get nodes --no-headers -o custom-columns=NAME:.metadata.name`

for NODE in ${NODES}; do
    echo ${NODE}
    echo `kubectl get node ${NODE} -o json | jq '.spec.taints'`
    echo
done