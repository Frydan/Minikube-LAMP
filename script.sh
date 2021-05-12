#!/bin/bash

# First clean everything up (all kubernetes files, docker images etc.)
./cleanup.sh

# Make docker see more of minikube resources
eval $(minikube docker-env) && \

# Delete Webhook validation for Minikube's Ingress to work
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

# Build our own docker image with PHP, Apache and PHP extensions
docker build . -f ./Dockerfile-apachephp -t apachephp && \
echo "=========================================" && \

# Create local docker registry
docker run -d --rm -p 5000:5000 --name registry registry:2  && \
echo "=========================================" && \

# Tag our PHP-Apache file and push it to local repository
docker tag apachephp:latest localhost:5000/apachephp && \
echo "Tag created!"  && \
echo "=========================================" && \
docker push localhost:5000/apachephp && \
echo "=========================================" && \

# Apply all files for local kubernetes cluster
kubectl apply -f ./kubernetes/secret.yaml && \
echo "=========================================" && \
kubectl apply -f ./kubernetes/apachephp-depl.yaml && \
echo "=========================================" && \
kubectl apply -f ./kubernetes/mysql-depl.yaml && \
echo "=========================================" && \
kubectl apply -f ./kubernetes/ingress.yaml



