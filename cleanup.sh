#!/bin/bash


# Make docker see more of minikube resources
eval $(minikube docker-env)

# Delete created Deployments, Services, Ingress, Persistent Volumes,
# Persistent Volume Claims and Secrets
kubectl delete deployment mysql-deployment
kubectl delete service mysql-service
kubectl delete deployment apachephp-deployment
kubectl delete service apachephp-service
kubectl delete deployment jenkins-deployment
kubectl delete service jenkins-service
kubectl delete ingress ingress
kubectl delete secret mysql-secret

# Delete Persistent Volumes and Persistent Volume Claims
# Can be commented
kubectl delete pvc mysql-pvc
kubectl delete pv mysql-pv


# Find and stop local docker registry
docker stop $(docker ps -a | grep registry:2 | cut -d' ' -f1)
docker rm $(docker ps -a | grep registry:2 | cut -d' ' -f1)

# Delete created images
#docker rmi apachephp
docker rmi localhost:5000/apachephp
