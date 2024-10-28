#!/bin/bash

service_name=$1
if [ -z "$service_name" ]; then 
    echo "Erreur : aucun nom de service founi."
    exit 1
fi 

service_status=$(systemctl is-active "$service_name")

if [ "$service_status" = "active" ]; then
    echo "$service_name est actif."
    exit 0
elif [ "$service_status" = "inactive" ]; then
    echo "$service_name est inactif."
    exit 1
else
    echo "$service_name est dans un état inconnu ou a échoué."
    exit 2
fi