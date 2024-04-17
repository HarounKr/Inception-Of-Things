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

echo "Waiting for GitLab to be ready..."
kubectl wait --for=condition=available --timeout=600s deployment/gitlab-webservice-default -n gitlab
echo "GitLab is now ready."

if ! grep -q "$entry" /etc/hosts; then
    echo "$entry" | sudo tee -a /etc/hosts > /dev/null
    echo "Added: $entry"
else
    echo "Line exist: $entry"
fi

kubectl get secret gitlab-gitlab-initial-root-password --namespace gitlab -ojsonpath='{.data.password}' | base64 --decode > password

# --adress=<hostIP> ; port 9191 ==> 8181 (gitlab-webservice port)
kubectl port-forward svc/gitlab-webservice-default 9191:8181 -n gitlab
