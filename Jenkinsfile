node('AnsibleMasterv1') {

    appname = 'simplewebapp'
    artifactory_repo = 'sudharsanc-simplewebappdocker.jfrog.io'
    chart_version = '0.1.0'
    app_version = '0.0.1'


    stage('Git Code Checkout'){
        git credentialsId: 'GitHub', url: 'https://github.com/SudharsanChinnappan/VzInfyPOC-CICD.git'
    }
    
    stage('Build Docker Image and Publish to JFrog docker registry'){


             sh "docker build . -t ${appname}"
             sh "docker tag ${appname} ${artifactory_repo}/${appname}:latest"
             sh "docker login -u admin -p jfrog@2020 ${artifactory_repo}"
             sh "docker push ${artifactory_repo}/${appname}:latest"


    }
    
        stage('Helm Repo add and Helm Packaging'){
            
            sh "helm repo add helm https://sudharsanc-simplewebappdocker.jfrog.io/artifactory/helm --username admin --password AP6we4X4QBTAVLsE4QNexyc6eFK"
            sh "helm package charts/simplewebapp-chart --version {{ chart_version }} --app-version {{ app_version }}"
            sh "curl -uadmin:AP6we4X4QBTAVLsE4QNexyc6eFK -T simplewebapp-chart-{{ chart_version }}.tgz 'https://sudharsanc-simplewebappdocker.jfrog.io/artifactory/helm/simplewebapp-chart-{{ chart_version }}.tgz'"
            sh "helm repo update"
            sh "echo chart_name: {{ simplewebapp-chart-{{ chart_version }} }} > playbooks/helm_variables"
    }
    stage('Create AWS EC2 Instances for K8 Cluster'){
            withCredentials([usernamePassword(credentialsId: 'awskey', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
            sh "bash scripts/createInstances.sh"
            sh "bash scripts/createInventory.sh"
             }
    }
        
    stage('Check SSH Connectivity to EC2 Instances from AnsibleMaster'){
            sh "cat inventory"
            sh "ansible kubernetes-master -i inventory -m ping"
            sh "ansible kubernetes-worker -i inventory -m ping"
    }         
    
    stage('K8 Installation and Cluster Configuration'){

            sh "ansible-playbook -i inventory playbooks/installing_kubernetes.yml"
            sh "ansible-playbook -i inventory playbooks/configure_master_node.yml"
            sh "ansible-playbook -i inventory playbooks/configure_worker_nodes.yml"
        //  sh "ansible-playbook -i inventory playbooks/create_pods.yml"
            sh "ansible-playbook -i inventory playbooks/install_helm_chart.yml"
    }
       
}