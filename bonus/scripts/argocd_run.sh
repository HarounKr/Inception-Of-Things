kubectl apply -f ../confs/argocd.yaml
kubectl port-forward service/wil-service 8888:80 -n dev