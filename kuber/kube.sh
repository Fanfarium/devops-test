kubectl apply -f sec-redis.yml
kubectl apply -f dep-redis.yml
kubectl apply -f service_redis.yml
kubectl wait --for=condition=available --timeout=6s deployment/redis
kubectl apply -f conf-nest.yml
kubectl apply -f dep-nest.yml
kubectl apply -f service-nest.yml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.1/deploy/static/provider/cloud/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=available --timeout=6s deployment/ingress-nginx-controller
kubectl apply -f ingress.yml
kubectl apply -f ingress-contr.yml
