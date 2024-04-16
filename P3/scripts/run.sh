sudo k3d cluster create P3cluster

mkdir ~/.kube
sudo k3d kubeconfig get P3cluster  > ~/.kube/config
sudo chmod 600 /home/hkrifa/.kube/config
echo "export KUBECONFIG=~/.kube/config" > ~/.profile
source ~/.profile

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD Server to become ready..."
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd
argocd_pass=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)
echo "Initial Argo CD password is: $argocd_pass"

kubectl port-forward svc/argocd-server -n argocd 8080:443 &

echo "Establishing port forwarding to Argo CD Server..."
while ! nc -z localhost 8080; do   
  sleep 1
done
echo "Port forwarding established."

kubectl create namespace dev
argocd login localhost:8080 --username admin --password $argocd_pass
argocd proj create development -d https://kubernetes.default.svc, dev -s '*'
kubectl apply -f ../confs/argocd.yaml

while ! kubectl get service wil-service -n dev; do
  echo "Waiting for wil-service to be created..."
  sleep 1
done
echo "Waiting for 'wil-service' to become ready in 'dev' namespace..."
kubectl wait --for=condition=available --timeout=600s deployment/wil-playground -n dev

kubectl port-forward service/wil-service 8888:80 -n dev &