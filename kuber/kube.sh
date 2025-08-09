kubectl apply -f ./kuber/sec-redis.yml
kubectl apply -f ./kuber/dep-redis.yml
kubectl apply -f ./kuber/service_redis.yml
kubectl wait --for=condition=available --timeout=6s deployment/redis
kubectl apply -f ./kuber/conf-nest.yml
kubectl apply -f ./kuber/dep-nest.yml
kubectl apply -f ./kuber/service-nest.yml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.1/deploy/static/provider/cloud/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=available --timeout=6s deployment/ingress-nginx-controller
kubectl apply -f ./kuber/ingress.yml
kubectl apply -f ./kuber/ingress-contr.yml
