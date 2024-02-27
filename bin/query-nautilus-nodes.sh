#!/bin/bash
# Query the list of Nautilus nodes.

kubectl get nodes -L gpu-type | awk '{ printf("[ \"node_type\": \"%s\", \"accelerator\": \"%s\" ],\n", $1, $6) }'

