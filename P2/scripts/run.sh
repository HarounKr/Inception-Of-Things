#!/bin/bash

entries=(
    "192.168.56.110 app1.com"
    "192.168.56.110 app2.com"
    "192.168.56.110 app3.com"
)

# Boucle à travers les entrées
for entry in "${entries[@]}"; do
    # Recherche si l'entrée existe déjà dans /etc/hosts
    if ! grep -q "$entry" /etc/hosts; then
        # Si l'entrée n'existe pas, l'ajoute au fichier
        echo "$entry" | sudo tee -a /etc/hosts > /dev/null
        echo "Added: $entry"
    else
        # Si l'entrée existe déjà, affiche un message
        echo "Line exist: $entry"
    fi
done