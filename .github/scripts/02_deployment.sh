#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <namespace> <deployment>"
    exit 1
fi

namespace=$1
deployment=$2

yaml_deployment_file="${namespace}_${deployment}.yaml"

cat <<EOF >$yaml_deployment_file
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: $namespace
  name: $deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $deployment
  template:
    metadata:
      labels:
        app: $deployment
    spec:
      containers:
        - env:
          - name: PORT
            value: '80'
          image: nginx
          name: $deployment
          ports:
            - containerPort: 80
EOF

kubectl apply -f "${yaml_deployment_file}"

rm "$yaml_deployment_file"

