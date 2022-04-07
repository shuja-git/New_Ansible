#!/bin/bash
#
#aws ec2 request-spot-instances --instance-count 1 --type "persistent" --launch-specification file://record.json --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" | jq

if [ -z "$1" ]; then
    echo -e "\e[1;31mInpute is missing"
    exit 1
fi
COMPONENT=$1

TEMP_ID="lt-0041090f0ef82990e"
VER=6
ZONE_ID=Z02080483A5K2UWOFAMM5


aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | sed 's/"//g' | grep -E 'running|stopped' &>/dev/null

if [ $? -eq 0 ]; then
  echo -e "\e[1;33mInstance already there"
  else
aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${VER} --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${COMPONENT}}]" "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
exit
fi


IPADDRESS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].PrivateIpAddress | sed 's/"//g' | grep -v null )

#Update the DNS record
sed -e "s/IPADDRESS/${IPADDRESS}/" -e "s/COMPONENT/${COMPONENT}/" rec.json &>/tmp/record.json

aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file:///tmp/record.json | jq
