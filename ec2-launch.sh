#!/bin/bash

aws ec2 request-spot-instances --instance-count 1 --type "persistent" --launch-specification file://record.json | jq