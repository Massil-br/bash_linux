#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Vous devez fournir un fichier texte contenant les noms des services à vérifier."
    exit 1
fi


if [ ! -f "$1" ]; then
    echo "Le fichier $1 n'existe pas ou n'est pas un fichier valide."
    exit 1
fi


services=()
while IFS= read -r line; do
    # Ajouter chaque ligne (nom de service) au tableau
    services+=("$line")
done < "$1"


for service in "${services[@]}"; do
    ./verif_service.sh "$service"
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "$service_name est actif."
    elif [ $exit_code -eq 1 ]; then
        echo "$service_name est inactif."
    elif [ $exit_code -eq 2 ]; then
        echo "$service_name a échoué."
    elif [ $exit_code -eq 3 ]; then
        echo "$service_name est en cours d'activation."
    elif [ $exit_code -eq 4 ]; then
        echo "$service_name est en cours de désactivation."
    elif [ $exit_code -eq 5 ]; then
        echo "$service_name a un état inconnu."
    elif [ $exit_code -eq 6 ]; then
        echo "$service_name est dans un état imprévu: $service_status."
    elif [ $exit_code -eq 7 ]; then 
        echo "Erreur : le service '$service_name' n'est pas installé ou reconnu."
    fi
done
