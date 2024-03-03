#make k8s cluster
terraform -chdir tf apply

#configure kubectl
gcloud container clusters get-credentials mygke-cluster-prod --region us-east1

# Create ArgoCD
kubectl create namespace argocd
kustomize build k8s/applications/argocd --enable-helm | kubectl apply -f -
kubens argocd

# UI
argocd admin initial-password -n argocd
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Create App of Apps
kubectl apply -f application-applications.yaml

# To add new apps make new subfolder under k8s and then add new entry in k8s/applications/kustomization.yaml
# This will use the argocd-apps helm chart to generate Application files using the template from the helm-charts/argocd-app