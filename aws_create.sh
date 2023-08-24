#!/bin/sh

INSTANCENAME=k8s

INSTANCETYPE=t3.micro

AMI_ID=ami-01476f51d7bd844ee

ZONE=subnet-0a3721f48b6b71c75

COUNTS=1

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count $COUNTS --instance-type $INSTANCETYPE --key-name filinta --security-group-ids sg-0e8a1d885359e7e03 --subnet-id $ZONE --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCENAME'}]' --query 'Instances[0].InstanceId'  --output text)


sleep 20

PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo $PUBLIC_IP
