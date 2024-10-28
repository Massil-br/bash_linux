#!/bin/bash

service_name=$1
if [ -z "$service_name" ]; then 
    echo "Erreur : aucun nom de service founi."
    exit 1
fi 

if ! systemctl list-units --type=service --all | grep -q "$service_name"; then
    echo "Erreur : le service '$service_name' n'est pas installé ou reconnu."
    exit 3
fi


service_status=$(systemctl is-active "$service_name")


if [ "$service_status" = "active" ]; then
    echo "$service_name est actif."
    exit 0
elif [ "$service_status" = "inactive" ]; then
    echo "$service_name est inactif."
    exit 1
elif [ "$service_status" = "failed" ]; then
    echo "$service_name a échoué."
    exit 3
elif [ "$service_status" = "activating" ]; then
    echo "$service_name est en cours d'activation."
    exit 4
elif [ "$service_status" = "deactivating" ]; then
    echo "$service_name est en cours de désactivation."
    exit 5
elif [ "$service_status" = "unknown" ]; then
    echo "$service_name a un état inconnu."
    exit 6
else
    echo "$service_name est dans un état imprévu: $service_status."
    exit 7
fi