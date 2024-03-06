# Prerequisites
# install terraform, gcloud, kubectl, kustomize, kubectx/kubens, argocd

#make k8s cluster
terraform -chdir=tf apply -auto-approve

#configure kubectl
gcloud container clusters get-credentials mygke-cluster-prod --region us-east1

# Create ArgoCD
kubectl create namespace argocd
kustomize build k8s/argocd --enable-helm | kubectl apply -f -
kubens argocd

# Wait 5 sec or get error
sleep 5

# Create App of Apps
kubectl apply -f appofapps.yaml

# To add new apps make new subfolder under k8s and then add new entry in k8s/applications/kustomization.yaml
# This will use the argocd-apps helm chart to generate Application files using the template from the helm-charts/argocd-app

# Wait or get error that secret is not found
sleep 30

# UI
argocd admin initial-password -n argocd
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward svc/argocd-server -n argocd 8080:443
# In browser, open https://localhost:8080

# When ready to tear down and clean up run
#terraform -chdir=tf destroy -auto-approve


##################################################
# external-dns
#  alternatively you can use wildcard domain
#  After deployed, you can add annotation (like app1.example.com) to a service and it will automatically make dns records (A and TXT) for that subdomain
# Tutorial
#  GKE and Cloud DNS - https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/gke.md
#   make cluster and clouddns zone
#   3 methods to grant externaldns permission to change clouddns zone
#  Deploy external-dns - https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/gke.md#deploy-externaldns
#   create deployment then verify with external LB or verify with ingress
#   dig on subdomain shows IP

##################################################
# cert-manager
# When you want a SSL cert on your ingress
# Tutorial
#  GKE - https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/
#   makes cluster w web server, then makes static IP
#   in domain registrar point A record to IP
#   create issuer for letsencrypt then reconfigure ingress for ssl