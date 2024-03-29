curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

sudo apt-get update
sudo apt-get install helm

kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab --timeout 600s \
  --namespace gitlab \
  --set global.hosts.domain=k3d.local \
  --set postgresql.image.tag=13.6.0 \
  --set certmanager.install=false \
  --set global.hosts.https=false \
  --set certmanager-issuer.email=me@example.com \
  --set global.edition=ce;

entry="127.0.0.1 gitlab.k3d.local"

if ! grep -q "$entry" /etc/hosts; then
    # Si l'entrée n'existe pas, l'ajoute au fichier
    echo "$entry" | sudo tee -a /etc/hosts > /dev/null
    echo "Added: $entry"
else
    # Si l'entrée existe déjà, affiche un message
    echo "Line exist: $entry"
fi
