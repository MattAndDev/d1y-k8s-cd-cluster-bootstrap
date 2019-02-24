#! /bin/bash
source .env

# For all files in templates -> sed replace $NAMESPACE_ID with $1 and wriite too one file in namespaces
find ./templates -type f -exec sed  -e "s/\$NAMESPACE_ID/$1/g" > ./namespaces/$1.yml {} \;

# apply what just created
kubectl --kubeconfig=$KUBECONFIG_PATH apply -f ./namespaces/$1.yml
