#k3d cluster create --network host --no-lb -p "80:80" flagger-demo2
k3d cluster create -p"80:80" flagger-another-try

sleep 10 

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
kubectl create ns ingress-nginx
helm upgrade -i ingress-nginx ingress-nginx/ingress-nginx \
--namespace ingress-nginx \
--set controller.metrics.enabled=true \
--set controller.podAnnotations."prometheus\.io/scrape"=true \
--set controller.podAnnotations."prometheus\.io/port"=10254

helm repo add flagger https://flagger.app

helm upgrade -i flagger flagger/flagger \
--namespace ingress-nginx \
--set prometheus.install=true \
--set meshProvider=nginx

helm upgrade -i flagger-loadtester flagger/loadtester

#kubectl apply -f deployment.yaml
#kubectl apply -f hpa.yaml
#kubectl apply -f ingress.yaml
#kubectl apply -f canary.yaml