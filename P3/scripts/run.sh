sudo k3d cluster create P3cluster

mkdir ~/.kube
sudo k3d kubeconfig get P3cluster  > ~/.kube/config
echo "export KUBECONFIG=~/.kube/config" > ~/.profile
source ~/.profile

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443

argocd admin initial-password -n argocd > argopass
kubectl create namespace dev
argocd proj create development -d https://kubernetes.default.svc, dev -s '*'
kubectl apply -f ../confs/argocd.yaml
sleep 2
kubectl port-forward service/wil-service 8888:80 -n dev
