#!/bin/sh

progress_bar() {
  duration="$1"
  bar_length=40
  sleep_duration=$(echo "$duration / $bar_length" | bc)

  i=0
  while [ "$i" -le "$bar_length" ]; do
    printf "\r["

    j=0
    while [ "$j" -lt "$i" ]; do
      printf "="
      j=$((j+1))
    done

    printf ">"

    j=$((i+1))
    while [ "$j" -lt "$bar_length" ]; do
      printf " "
      j=$((j+1))
    done

    printf "] %d%%" "$((i*100/bar_length))"

    sleep "$sleep_duration"
    i=$((i+1))
  done

  printf "\n"
}


INSTANCENAME=k8s

echo "Creating $INSTANCENAME server"

INSTANCETYPE=t3.micro

AMI_ID=ami-01476f51d7bd844ee

ZONE=subnet-0a3721f48b6b71c75

COUNTS=1

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count $COUNTS --instance-type $INSTANCETYPE --key-name filinta --security-group-ids sg-0e8a1d885359e7e03 --subnet-id $ZONE --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCENAME'}]' --query 'Instances[0].InstanceId'  --output text)

progress_bar 40

echo "$INSTANCENAME Server Created Successfully!"


