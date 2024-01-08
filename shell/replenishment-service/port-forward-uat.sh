#!/bin/bash

# Define the label selectors for each service
cis_selector="app=hdr-inventory-service"
cis_namespace="uat-inventory"
cis_port=8088

ims_internal_selector="app=ims-internal-api"
ims_internal_namespace="uat-ship"
ims_internal_port=8091

kms_selector="app=kitchen-management-service"
kms_namespace="uat-hdr"
kms_port=8092

kcs_selector="app=kitchen-cooking-service-v2"
kcs_namespace="uat-hdr"
kcs_port=8093

recipe_selector="app=recipe-service-v2"
recipe_namespace="uat-master-data"
recipe_port=8094

restaurant_selector="app=restaurant-service-v2"
restaurant_namespace="uat-consumer"
restaurant_port=8095

replenishment_selector="app=replenishment-service"
replenishment_namespace="uat-ship"
replenishment_port=8096


kubectl config use-context FTIUatAKSClusterV2

# Port forward the pods for each service
kubectl port-forward $(kubectl get pods -n $recipe_namespace -l $recipe_selector -o jsonpath='{.items[0].metadata.name}') $recipe_port:8443 -n $recipe_namespace &

kubectl port-forward $(kubectl get pods -n $ims_internal_namespace -l $ims_internal_selector -o jsonpath='{.items[0].metadata.name}') $ims_internal_port:8080 -n $ims_internal_namespace &

kubectl port-forward $(kubectl get pods -n $restaurant_namespace -l $restaurant_selector -o jsonpath='{.items[0].metadata.name}') $restaurant_port:8443 -n $restaurant_namespace &

kubectl port-forward $(kubectl get pods -n $cis_namespace -l $cis_selector -o jsonpath='{.items[0].metadata.name}') $cis_port:8443 -n $cis_namespace &

kubectl port-forward $(kubectl get pods -n $kms_namespace -l $kms_selector -o jsonpath='{.items[0].metadata.name}') $kms_port:8443 -n $kms_namespace &

kubectl port-forward $(kubectl get pods -n $kcs_namespace -l $kcs_selector -o jsonpath='{.items[0].metadata.name}') $kcs_port:8443 -n $kcs_namespace &

kubectl port-forward $(kubectl get pods -n $replenishment_namespace -l $replenishment_selector -o jsonpath='{.items[0].metadata.name}') $replenishment_port:8443 -n $replenishment_namespace &

#kubectl port-forward redis-0 $cis_redis_port:6379 -n $cis_namespace &
# Wait for all port forwarding to complete
wait
