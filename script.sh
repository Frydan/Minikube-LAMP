#!/bin/bash


# While "continue" variable is true continue executing next steps
continue=true

# First clean everything up (all kubernetes files, docker images etc.)
./cleanup.sh

# Make docker see more of minikube resources
echo "INFO: Configuring Docker <---> Kubernetes enviorment"  && \
eval $(minikube docker-env) && \
echo "Success"  || \
continue=false

if $continue
then
	# Delete Webhook validation for Minikube's Ingress to work
	echo "INFO: Deleting Ingress Webhook validation"  && \
	kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
	echo "Success"
	echo "========================================="
fi

if $continue
then
	# Build our own docker image with PHP, Apache and PHP extensions
	echo "INFO: Building ApachePHP image"  && \
	docker build . -f ./Dockerfile-apachephp -t apachephp && \
	echo "Success" || \
	continue=false
	echo "========================================="
fi

if $continue
then
	# Create local docker registry
	echo "INFO: Creating local docker registry"  && \
	docker run -d --rm -p 5000:5000 --name registry registry:2  && \
	echo "Success" || \
	continue=false
	echo "========================================="
fi

if $continue
then
	# Tag our PHP-Apache file and push it to local repository
	echo "INFO: Pushing ApachePHP to local docker repository"  && \
	docker tag apachephp:latest localhost:5000/apachephp && \
	docker push localhost:5000/apachephp && \
	echo "Success" || \
	continue=false
	echo "========================================="
fi

if $continue
then
	if [ $? -gt 0 ]
	then
	    echo "WARNING: There were some problems with local Docker repository"
	else
		echo "SUCCESS: Docker repository was created correctly!"
	fi
fi


if $continue
then
	# Apply all files for local kubernetes cluster
	echo "=========================================" && \
	echo "INFO: Applying Kubernetes elements" && \
	kubectl apply -f ./kubernetes/secret.yaml && \
	echo "=========================================" && \
	kubectl apply -f ./kubernetes/apachephp-depl.yaml && \
	echo "=========================================" && \
	kubectl apply -f ./kubernetes/mysql-depl.yaml && \
	echo "=========================================" && \
	kubectl apply -f ./kubernetes/ingress.yaml
fi

if $continue
then
	if [ $? -gt 0 ]
	then
	    echo "WARNING: There were some problems with applying Kubernetes files"
	else
	    echo "SUCCESS: All Kubernetes files were applied correctly!"
	fi
fi

