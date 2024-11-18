#!/bin/bash

service_name=$1
if [ -z "$service_name" ]; then 
    echo "Erreur : aucun nom de service founi."
    exit 8
fi 


if ! systemctl list-unit-files --type=service | grep -qw "$service_name"; then
    echo "Erreur : le service '$service_name' n'existe pas."
    exit 7
fi


service_status=$(systemctl is-active "$service_name")

if [ "$service_status" = "active" ]; then
    exit 0
elif [ "$service_status" = "inactive" ]; then
    exit 1
elif [ "$service_status" = "failed" ]; then
    exit 2
elif [ "$service_status" = "activating" ]; then
    exit 3
elif [ "$service_status" = "deactivating" ]; then
    exit 4
elif [ "$service_status" = "unknown" ]; then
    exit 5
else
    exit 6
fi