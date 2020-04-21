#!bin/bash
aws cloudformation create-stack \
--region us-east-1 \
--stack-name VzInfyPOC-SimpleWebApp \
--template-body file://cf-template/createSimpleWebApp.yml \
--parameters ParameterKey=NetworkStackName,ParameterValue=VzInfyPOC-Network \
ParameterKey=ApplicationName,ParameterValue=VzInfyPOC-SimpleWebApp \
ParameterKey=InstanceType,ParameterValue=t2.micro \
ParameterKey=KeyName,ParameterValue=ansiblekey \
ParameterKey=Environment,ParameterValue=DEV
aws cloudformation wait stack-create-complete --stack-name VzInfyPOC-SimpleWebApp --region us-east-1
