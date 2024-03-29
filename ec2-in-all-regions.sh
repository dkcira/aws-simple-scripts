#!/bin/bash 
# list ec2 instances in all available aws regions

set -o nounset

for region in $(aws ec2 describe-regions --output text | cut -f3)
do
  echo "Instances in region:'$region'"
  aws ec2 describe-instances --query \
   "Reservations[*].Instances[*].{IP:PublicIpAddress,ID:InstanceId,Type:InstanceType,State:State.Name,Name:Tags[0].Value}" \
   --output=table --region $region
done


