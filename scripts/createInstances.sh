#!bin/bash
aws cloudformation create-stack \
--region us-east-1 \
--stack-name VzInfyPOC-MyWebApp \
--template-body file://cf-template/createSimpleWebApp.yml \
--parameters ParameterKey=NetworkStackName,ParameterValue=VzInfyPOC-Network \
ParameterKey=ApplicationName,ParameterValue=VzInfyPOC-MyWebApp \
ParameterKey=InstanceType,ParameterValue=t2.micro \
ParameterKey=KeyName,ParameterValue=ansiblekey \
ParameterKey=Environment,ParameterValue=DEV
aws cloudformation wait stack-create-complete --stack-name VzInfyPOC-MyWebApp --region us-east-1
