#!/bin/bash
#
#aws ec2 request-spot-instances --instance-count 1 --type "persistent" --launch-specification file://record.json --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" | jq

TEMP_ID="lt-0041090f0ef82990e"
VER=4
aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${VER} --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=string,Value=frontend}]" "ResourceType=instance,Tags=[{Key=string,Value=frontend}]" | jq
