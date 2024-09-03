#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <namespace> <deployment>"
    exit 1
fi

namespace=$1
deployment=$2

yaml_service_file="${namespace}_svc-${deployment}.yaml"

cat <<EOF >$yaml_service_file
apiVersion: v1
kind: Service
metadata:
  annotations:
  namespace: $namespace
  name: svc-$deployment
spec:
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 80
    - name: tcp
      port: 443
      protocol: TCP
      targetPort: 443
  selector:
    app: $deployment
  sessionAffinity: None
  type: ClusterIP
EOF

kubectl apply -f "${yaml_service_file}"

rm "$yaml_service_file"