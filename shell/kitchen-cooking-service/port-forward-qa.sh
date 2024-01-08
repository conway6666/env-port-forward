#!/bin/bash

# Define the label selectors for each service
cis_selector="app=hdr-inventory-service"
cis_namespace="dev-inventory"
cis_port=8088

kms_selector="app=kitchen-management-service"
kms_namespace="dev-hdr"
kms_port=8441

kubectl config use-context FTIDevAKSClusterV2

# Port forward the pods for each service
kubectl port-forward $(kubectl get pods -n $cis_namespace -l $cis_selector -o jsonpath='{.items[0].metadata.name}') $cis_port:8443 -n $cis_namespace &

kubectl port-forward $(kubectl get pods -n $kms_namespace -l $kms_selector -o jsonpath='{.items[0].metadata.name}') $kms_port:8443 -n $kms_namespace &
#kubectl port-forward redis-0 $cis_redis_port:6379 -n $cis_namespace &
# Wait for all port forwarding to complete
wait
