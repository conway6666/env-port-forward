#!/bin/bash


shipping_selector="app=shipping-service"
shipping_namespace="dev-shipping"
shipping_port=8445

kubectl config use-context FTIDevAKSClusterV2

# Port forward the pods for each service
kubectl port-forward $(kubectl get pods -n $shipping_namespace -l $shipping_selector -o jsonpath='{.items[0].metadata.name}') $shipping_port:8443 -n $shipping_namespace &
#kubectl port-forward redis-0 $cis_redis_port:6379 -n $cis_namespace &
# Wait for all port forwarding to complete
wait
