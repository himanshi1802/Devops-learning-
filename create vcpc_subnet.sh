#!/bin/bash


############################################
#Description: Create VPC and public Subnet
#- verify if user has aws installed and configured
# when we call this script , it takes two paarameter create helps to create vpc and subnet and delete helps in deletion of both

############################################

#Verify if aws is installed
command -v aws >/dev/null 2>&1 || { echo >&2 "AWS CLI is not installed. Please install it and configure it. Aborting."; exit 1; }

#Verify if aws is configured
aws sts get-caller-identity || { echo >&2 "AWS CLI is not configured. Please configure it. Aborting."; exit 1; }

#Create VPC
vpc_id=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
echo "VPC ID '$vpc_id' CREATED."

#Add Name tag to VPC
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value=MyVPC
echo "VPC ID '$vpc_id' NAMED as 'MyVPC'."
#Create Public Subnet
subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)
echo "Subnet ID '$subnet_id' CREATED."

#Add Name tag to Public Subnet
aws ec2 create-tags --resources $subnet_id --tags Key=Name,Value=PublicSubnet
echo "Subnet ID '$subnet_id' NAMED as 'PublicSubnet'."

#Create Internet Gateway
gateway_id=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
echo "Internet Gateway ID '$gateway_id' CREATED."

