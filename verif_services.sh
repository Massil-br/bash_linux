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
        echo "$service Validé."
    else
        echo "$service Echec"
    fi
done
