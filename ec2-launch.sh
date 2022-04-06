#!/bin/bash

aws ec2 request-spot-instances --instance-count 1 --type "persistent" --launch-specification file://record.json --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=frontend}]" | jq