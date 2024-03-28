curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

sudo apt-get update
sudo apt-get install helm

kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab --timeout 600s \
  --namespace gitlab \
  --set global.hosts.domain=k3d.local \
  --set global.hosts.externalIP=172.19.80.215 \
  --set certmanager-issuer.email=me@example.com \
  --set postgresql.image.tag=13.6.0
