#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Vous devez mettre au moins un argument : $0 service1  service2 ..."
    exit 1
fi

services=("$@")



for service in "${services[@]}"; do
    ./verif_service.sh "$service"
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "$service est en cours d'exécution."
    elif [ $exit_code -eq 1 ]; then 
        echo "$service est inactif."
    elif [ $exit_code -eq 3 ]; then
        echo "$service n'est pas installé sur votre système."
    else
        echo "$service a échoué ou est dans un état inconnu."
    fi
done
