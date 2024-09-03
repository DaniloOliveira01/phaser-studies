#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <#> <AWS_SECRET_ACCESS_KEY> <AWS_SECRET_ACCESS_KEY> <HOSTED_ZONE_ID> <SUB_DOMAIN> <CNAME>"
    exit 1
fi

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export AWS_DEFAULT_REGION='us-east-1'

HOSTED_ZONE_ID=$3
SUB_DOMAIN=$4
CNAME=$5

TTL=300
SLEEP=15

created=$(aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --query "ResourceRecordSets[?Name == '$SUB_DOMAIN.'].Name" --output text)

if [[ -z "$created" ]]; then 
  CHANGE_ID=$(aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch '{
    "Changes": [{
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "'"$SUB_DOMAIN"'",
        "Type": "CNAME",
        "TTL": '$TTL',
        "ResourceRecords": [{
          "Value": "'"$CNAME"'"
        }]
      }
    }]
  }' --query 'ChangeInfo.Id' --output text)

  while true; do
    status=$(aws route53 get-change --id $CHANGE_ID --query 'ChangeInfo.Status' --output text)
    echo "$status"
    if [[ "$status" == "INSYNC" ]]; then     
      break
    else 
      sleep $SLEEP
    fi 
  done
else 
  echo "$SUB_DOMAIN already created"
fi 

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_DEFAULT_REGION