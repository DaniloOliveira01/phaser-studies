#!/bin/bash
if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <namespace> <deployment> <letsencrypt> <host>"
    exit 1
fi

namespace=$1
deployment=$2
letsencrypt=$3 #staging - prod
host=$4
secret=$(echo "$host" | tr '.' '-')

yaml_ingress_file="${namespace}_ingress-${deployment}.yaml"


cat <<EOF >$yaml_ingress_file
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: $namespace
  name: ingress-$deployment
  annotations:
    ingress.kubernetes.io/ssl-redirect: 'true'
    cert-manager.io/cluster-issuer: letsencrypt-$letsencrypt
spec:
  ingressClassName: nginx
  rules:
    - host: $host
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: svc-$deployment
                port:
                  number: 80
  tls:
    - hosts:
        - $host
      secretName: letsencrypt-$secret
EOF

kubectl apply -f "${yaml_ingress_file}"

rm "$yaml_ingress_file"

SLEEP=15

while true; do   

  protocol=""

  if [[ "$letsencrypt" == "staging" ]]; then 
    protocol="http://"
  fi

  if [[ "$letsencrypt" == "prod" ]]; then 
    protocol="https://"
  fi

  status_code=$(curl -Is "$protocol$host" | head -n 1)

  echo "STATUS CODE: $status_code"
  if [[ "$status_code" == *"200"* || "$status_code" == *"308"* ]]; then 
    echo "$host ready"
    break
  else 
    echo "$host not ready"
    sleep $SLEEP
  fi 
done