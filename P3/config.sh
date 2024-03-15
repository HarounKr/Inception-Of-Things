sudo k3d cluster create P3cluster
mkdir ~/.kube
sudo k3d kubeconfig get P3cluster  > ~/.kube/config
echo "export KUBECONFIG=~/.kube/config" > ~/.profile
source ~/.profile
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
