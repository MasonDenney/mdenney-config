#terraform apply
#gcloud container clusters get-credentials mygke-cluster-prod --region us-east1
kubectl create namespace argocd
kustomize build applications/infra/argocd/do --enable-helm | kubectl apply -f -
kubens argocd
kustomize build meta/do --enable-helm | kubectl apply -f -
#Warning: metadata.finalizers: "resources-finalizer.argocd.argoproj.io": prefer a domain-qualified finalizer name to avoid accidental conflicts with other finalizer writers
#Error from server (BadRequest): error when creating "STDIN": AppProject in version "v1alpha1" cannot be handled as a AppProject: strict decoding error: unknown field "spec.namespaceResourceBlacklist[2].orphanedResources", unknown field "spec.namespaceResourceBlacklist[2].roles"
#IN ARGOCD - InvalidSpecError Application referencing project guestbook which does not exist

# UI
#kubectl port-forward svc/argocd-server -n argocd 8080:443
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
