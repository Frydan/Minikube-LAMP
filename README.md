# Minikube LAMP Cluster!
Requirements:
 - Minikube
 - Kubectl
 - Docker

To create local Minikube LAMP stack follow the steps listed below:

**1. Create local Minikube cluster and enable Ingress**
>$ minikube start
>$ minikube addons enable ingress
>$ minikube addons enable ingress-dns

**2. Clone this repository**
> $ git clone https://github.com/Frydan/Minikube-LAMP-Cluster.git

**3. To create LAMP stack use provided script**
> $ sudo chmod +x ./script.sh
> $ ./script.sh

The script will automatically try to do these things:
(for more details check the script itself)

 - Clean up everything it created before (Added it at the beginning just so it can be used also as  a "stack-restart" script)
 - Build Apache-PHP docker image with all required extensions for LAMP stack and all files from **website** directory.
 - Create local docker repository
 - Push created Apache-PHP image to this repository
 - Create Kubernetes stack with: 
	 - Secret
	 - Apache-PHP deployment with image pulled from local docker repository
	 - MySQL deployment
	 - Ingress
	 
**4. If everything has gone correctly you can check the output of following commands:**
>$ kubectl get pods
>$ kubectl get service
>$ kubectl get ingress
>$ kubectl get pv
>$ kubectl get pvc


**5. You can use provided script to insert example data into MySQL database**
> $ sudo chmod +x ./insertToDB.sh
> $ ./insertToDB.sh

Now you should be able to get Ingress IP address and and check whether everything works correctly
>$ kubectl get ingress

Copy the IP address under "ADDRESS" and paste it in your web browser.
If you added data to database with **./insertToDB.sh** You should be able to see 4 example products

You should also be able to modify the database using
> $ kubectl exec -it <HERE_PASTE_MYSQL_POD_NAME> -- /bin/bash

Then inside the pod log in to database using any of the default credentials:

username: **dbconnect**
password: **1239ni22md**

OR

username: **root**
password: **reTsec132409**
> \# mysql -u root -p
Enter password: reTsec132409
> mysql> USE webAppDB;

Then you can execute any MySQL DDL, DML, DQL or any other type of query inside the database

**To revert all made changes you can use cleanup script**
> $ sudo chmod +x  ./cleanup.sh
> $ ./cleanup.sh



# INCLUDED FILES
**./script.sh** - Main script putting everything together

**./cleanup.sh** - Script for cleaning up everything created by ./script.sh

**./insertDataToDB.sh** - Script to quickly add example data to Database (used SQL commands are stored inside **sql** directory)

**Dockerfile-apachephp** - Dockerfile used to create Apache-PHP docker image with all required extensions

**kuberneres** - Directory where all Kubernetes configuration files are stored

**website** - Directory with PHP website files using which our Docker image is created

**sql** - Directory where simple example SQL query is stored, which is used by **./insertDataToDB.sh**


