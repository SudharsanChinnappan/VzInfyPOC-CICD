#!bin/bash
wget  ‘https://get.helm.sh/helm-v3.2.0-linux-amd64.tar.gz’
tar -xvf helm-v3.2.0-linux-amd64.tar.gz
sudo cp linux-amd64/helm /bin/
helm repo add helm https://csudharsan.jfrog.io/artifactory/helm --username admin --password AP5sHFBRdT4tZ1ui1z1JWi6UbNU
helm repo update
