#!/bin/bash

sudo apt install docker.io

# Containerizing the sample Flask API
# This is the command used to build the docker image, can be used for verification or testing
#sudo docker build --tag sample-api .
# The actual image deployed to minikube is the same one pre-uploaded to dockerhub under user yashrajg

# Install kubectl
sudo apt-get update
sudo apt-get install -y --upgrade ca-certificates curl
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install minikube for a local kubernetes cluster
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

# Start minikube
echo STARTING MINIKUBE
echo THIS MAY TAKE A LOT OF TIME FOR THE FIRST RUN
minikube start

# Deploy Kubernetes Resouces for the API

# Pulls the latest image by default (i.e. one with the latest tag)
#kubectl create deployment sample-api --image=yashrajg/flask-stub-api

kubectl apply -f  kubernetes-deployments/Deployment.yaml
kubectl expose deployment sample-api --type=LoadBalancer --port=5000
kubectl apply -f kubernetes-deployments/HorizontalPodAutoscaler.yaml

echo THE API URL IS
minikube service sample-api --url

