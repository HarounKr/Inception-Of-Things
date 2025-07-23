#!/bin/bash

# Vérifier si un paramètre a été fourni
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <P1|P2|P3>"
  exit 1
fi

# Assigner le paramètre à une variable
PROJECT_DIR=$1

# Vérifier que le paramètre est l'un des dossiers attendus
if [[ "$PROJECT_DIR" != "P1" && "$PROJECT_DIR" != "P2" && "$PROJECT_DIR" != "P3" ]]; then
  echo "Le paramètre doit être P1, P2 ou P3."
  exit 1
fi

# Aller dans le dossier spécifié
cd "$PROJECT_DIR"

# Vérifier que la commande cd a réussi
if [ $? -ne 0 ]; then
  echo "Impossible de changer de répertoire vers $PROJECT_DIR. Assurez-vous que le dossier existe."
  exit 1
fi

echo "Dans le dossier $PROJECT_DIR, suppression des VMs gérées par VirtualBox..."

echo "VMs actuellement gérées par VirtualBox:"
VBoxManage list vms

for vm in $(VBoxManage list vms | cut -d '"' -f 2); do
    echo "Arrêt de la VM: $vm"
    VBoxManage controlvm "$vm" poweroff
done

for vm in $(VBoxManage list vms | cut -d '"' -f 2); do
    echo "Suppression de la VM: $vm"
    VBoxManage unregistervm "$vm" --delete
done

echo "Suppression du dossier .vagrant et destruction des VMs avec Vagrant..."
rm -rf ./.vagrant
vagrant destroy -f

echo "Toutes les VMs et configurations de Vagrant dans $PROJECT_DIR ont été supprimées."
