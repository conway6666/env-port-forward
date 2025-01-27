#!/bin/bash

# Define the label selectors for each service
recipe_selector="app=recipe-service-v2"
ims_internal_selector="app=ims-internal-api"
ims_inventory_order_selector="app=ims-inventory-order-service"
restaurant_selector="app=restaurant-service-v2"
cis_selector="app=hdr-inventory-service"
kos_selector="app=kitchen-order-service"
kms_selector="app=kitchen-management-service"
hot_holding_service_selector="app=hot-holding-service"

# Define the namespace and port numbers for each service
recipe_namespace="uat-master-data"
recipe_port=8092
ims_internal_namespace="uat-ship"
ims_internal_port=8094
ims_inventory_order_namespace="uat-ship"
ims_inventory_order_port=8099
restaurant_namespace="uat-consumer"
restaurant_port=8093
cis_namespace="uat-inventory"
cis_port=8088

kos_namespace="uat-hdr"
kos_port=8090
kms_namespace="uat-hdr"
kms_port=8091
hot_holding_service_port=9123


kubectl config use-context FTIUatAKSClusterV2

# Port forward the pods for each service
kubectl port-forward $(kubectl get pods -n $recipe_namespace -l $recipe_selector -o jsonpath='{.items[0].metadata.name}') $recipe_port:8443 -n $recipe_namespace &

kubectl port-forward $(kubectl get pods -n $ims_internal_namespace -l $ims_internal_selector -o jsonpath='{.items[0].metadata.name}') $ims_internal_port:8080 -n $ims_internal_namespace &

kubectl port-forward $(kubectl get pods -n $ims_inventory_order_namespace -l $ims_inventory_order_selector -o jsonpath='{.items[0].metadata.name}') $ims_inventory_order_port:8443 -n $ims_inventory_order_namespace &

kubectl port-forward $(kubectl get pods -n $restaurant_namespace -l $restaurant_selector -o jsonpath='{.items[0].metadata.name}') $restaurant_port:8443 -n $restaurant_namespace &

kubectl port-forward $(kubectl get pods -n $cis_namespace -l $cis_selector -o jsonpath='{.items[0].metadata.name}') $cis_port:8443 -n $cis_namespace &

kubectl port-forward $(kubectl get pods -n $kos_namespace -l $kos_selector -o jsonpath='{.items[0].metadata.name}') $kos_port:8443 -n $kos_namespace &

kubectl port-forward $(kubectl get pods -n $kms_namespace -l $kms_selector -o jsonpath='{.items[0].metadata.name}') $kms_port:8443 -n $kms_namespace &

kubectl port-forward $(kubectl get pods -n $ims_internal_namespace -l $hot_holding_service_selector -o jsonpath='{.items[0].metadata.name}') $hot_holding_service_port:8443 -n $ims_internal_namespace &


# Wait for all port forwarding to complete
wait
