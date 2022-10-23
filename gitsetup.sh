
cd /usercode/system/infrastructure

kubectl apply -f deployment.yaml
kubectl apply -f hpa.yaml
kubectl apply -f service.yaml

EXTERNAL_IP=$(kubectl get service ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

sed -i 's/${INGRESS_EXTERNAL_IP}/$EXTERNAL_IP/' ingress.yaml
sed -i 's/${INGRESS_EXTERNAL_IP}/$EXTERNAL_IP/' canary.yaml

kubectl apply -f ingress.yaml
kubectl apply -f canary.yaml
