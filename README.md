# Homelab


## Kubernetes
### Setup
#### Dashboard
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

#### Admin Account

https://ubuntu.com/kubernetes/install

```bash
sudo k8s kubectl create sa kube-admin
sudo k8s kubectl create clusterrolebinding kube-admin   --clusterrole=cluster-admin   --serviceaccount=default:kube-admin
```

#### Ingress Controller
##### Traefik
```bash
helm install -f traefik/traefik-values.yml traefik traefik/traefik
k create -f traefik/middlewares/middleware.yml
```

#### Certmanager
https://cert-manager.io/docs/installation/kubectl/
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.17.0/cert-manager.yaml

kubectl config set-context --current --namespace=cert-manager
k apply -f cert-manager/issuer-prod.yaml
#https://letsencrypt.org/docs/staging-environment/
k apply -f cert-manager/issuer-staging.yaml
```