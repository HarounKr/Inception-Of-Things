#kubectl get deployments/gitlab-webservice-default -n gitlab 
#kubectl get deployment gitlab-webservice-default -n gitlab -o=jsonpath='{.status.conditions[?(@.type=="Available")].status}'
kubectl get secret gitlab-gitlab-initial-root-password --namespace gitlab -ojsonpath='{.data.password}' | base64 --decode > password

# --adress=<hostIP> ; port 9191 ==> 8181 (gitlab-webservice port)
kubectl port-forward svc/gitlab-webservice-default 9191:8181 -n gitlab
