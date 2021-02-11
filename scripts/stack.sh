#!/bin/zsh

aws --region eu-west-1 cloudformation create-stack --stack-name VPCStack --template-body file://vpc/vpc-3azs.yaml --parameters file://vpc/vpc-3azs_param_prod.json 
aws --region eu-west-1 cloudformation update-stack --stack-name VPCStack --template-body file://vpc/vpc-3azs.yaml --parameters file://vpc/vpc-3azs_param_prod.json 

 
#Require Parameter modification
aws --region eu-west-1 cloudformation create-stack --stack-name VPCNatGWZoneA --template-body file://vpc/vpc-nat-gateway.yaml --parameters file://vpc/vpc-nat-gateway_param_prod.json 
#

######Alerts
aws --region eu-west-1 cloudformation create-stack --stack-name AlertsStack --template-body file://operations/alert.yaml --parameters file://operations/alert_param_prod.json 

######### KMS
aws --region eu-west-1 cloudformation create-stack --stack-name KMSHAStack --template-body file://security/kms-key.yaml --parameters file://security/kms-key_param_prod.json


######VPC Flow
aws --region eu-west-1 cloudformation create-stack --stack-name VPCFlowStack --template-body file://vpc/vpc-flow-logs.yaml --parameters file://vpc/vpc-flow-logs_param_prod.json --capabilities CAPABILITY_IAM

#Security Groups
aws --region eu-west-1 cloudformation create-stack --stack-name DBClientSGStack --template-body file://state/db-client-sg.yaml --parameters file://state/db-client-sg_param_prod.json


# Serverless
aws --region eu-west-1 cloudformation create-stack --stack-name AuroraHAServerlessStack --template-body file://state/rds-aurora-serverless.yaml --parameters file://state/rds-aurora-serverless_param_prod.json
aws --region eu-west-1 cloudformation update-stack --stack-name AuroraHAServerlessStack --template-body file://state/rds-aurora-serverless.yaml --parameters file://state/rds-aurora-serverless_param_prod.json

# Provisioned
aws --region eu-west-1 cloudformation create-stack --stack-name AuroraHAProvisionedStack --template-body file://state/rds-aurora.yaml --parameters file://state/rds-aurora_param_prod.json
aws --region eu-west-1 cloudformation update-stack --stack-name AuroraHAProvisionedStack --template-body file://state/rds-aurora.yaml --parameters file://state/rds-aurora_param_prod.json

#DMS
aws --region eu-west-1 cloudformation create-stack --stack-name DMSHAStack --template-body file://dms/dms.yaml --parameters file://dms/dms_param_prod.json --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
aws --region eu-west-1 cloudformation update-stack --stack-name DMSHAStack --template-body file://dms/dms.yaml --parameters file://dms/dms_param_prod.json --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM


