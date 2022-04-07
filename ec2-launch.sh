#!/bin/bash
#
#aws ec2 request-spot-instances --instance-count 1 --type "persistent" --launch-specification file://record.json --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" | jq


aws ec2 describe-instances --filters "Name=tag:Name,Values=frontend" | jq .Reservations[].Instances[].State.Name | sed 's/"//g' | grep -E 'running|stopped' &>/dev/null
if [ $? -eq 0 ]; then
  echo -e "\e[1;31mInstance already there"
  exit
fi

TEMP_ID="lt-0041090f0ef82990e"
VER=6
aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${VER} --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" "ResourceType=instance,Tags=[{Key=Name,Value=frontend}]" | jq
