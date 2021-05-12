#!/bin/bash

# First find full name of MySQL database Pod
mysqlPod=$(kubectl get pods | grep "mysql-deployment" | cut -d' ' -f1)

# Use this name to insert data into database
kubectl exec -it "$mysqlPod" -- sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < ./sql/data.sql