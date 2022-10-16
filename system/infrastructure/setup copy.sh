#k3d cluster create --network host --no-lb -p "80:80" flagger-demo2
k3d cluster create -p "80:80" flagger-demo

helm repo add traefik https://helm.traefik.io/traefik
kubectl create ns traefik

cat <<EOF | helm upgrade -i traefik traefik/traefik --namespace traefik -f -
deployment:
  podAnnotations:
    prometheus.io/port: "9100"
    prometheus.io/scrape: "true"
    prometheus.io/path: "/metrics"
metrics:
  prometheus:
    entryPoint: metrics
EOF

# Install Traefik Resource Definitions:
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

# Install RBAC for Traefik:
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml

helm repo add flagger https://flagger.app

helm upgrade -i flagger flagger/flagger \
--namespace traefik \
--set prometheus.install=true \
--set meshProvider=traefik

helm upgrade -i flagger-loadtester flagger/loadtester

kubectl apply -f deployment.yaml
kubectl apply -f hpa.yaml
kubectl apply -f ingress.yaml
kubectl apply -f canary.yaml