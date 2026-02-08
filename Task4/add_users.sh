#!/bin/bash

mkdir -p users
USERS=("devops" "developer" "analyst" "main_devops")

for USER in "${USERS[@]}"; do
  openssl genrsa -out users/$USER.key 2048
  openssl req -new -key users/$USER.key -out users/$USER.csr -subj "//CN=$USER"
  openssl x509 -req -in users/$USER.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key \
    -CAcreateserial -out users/$USER.crt -days 365
  echo "Certificate created for user $USER"
done

CLUSTER_NAME=$(kubectl config view -o jsonpath='{.clusters[0].name}')

for USER in "${USERS[@]}"; do
  kubectl config set-credentials $USER \
    --client-certificate=users/$USER.crt \
    --client-key=users/$USER.key \
    --embed-certs=true

  kubectl config set-context $USER-context \
    --cluster=$CLUSTER_NAME \
    --user=$USER
done



