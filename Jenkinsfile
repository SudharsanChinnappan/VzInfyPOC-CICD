node('AnsibleMasterv1') {
    stage('Git Code Checkout'){
        git credentialsId: 'GitHub', url: 'https://github.com/SudharsanChinnappan/VzInfyPOC-CICD.git'
    }
    
    stage('Build Docker Image and Publish to JFrog docker registry'){
        appname = 'simplewebapp'
        artifactory_repo = 'sudharsanc-simplewebappdocker.jfrog.io'

             sh "docker build . -t ${appname}"
             sh "docker tag ${appname} ${artifactory_repo}/${appname}:latest"
             sh "docker login -u admin -p jfrog@2020 ${artifactory_repo}"
             sh "docker push ${artifactory_repo}/${appname}:latest"


    }
    
    stage('create aws instances'){
            withCredentials([usernamePassword(credentialsId: 'awskey', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
            sh "bash scripts/createInstances.sh"
            sh "bash scripts/createInventory.sh"
    }
        
    stage('Register Instances for Ansible'){
        sh "cat inventory"
        sh "ansible kubernetes-master -i inventory -m ping"
        sh "ansible kubernetes-worker -i inventory -m ping"
        sh "ansible-playbook -i inventory playbooks/installing_kubernetes.yml"
        sh "ansible-playbook -i inventory playbooks/configure_master_node.yml"
        sh "ansible-playbook -i inventory playbooks/configure_worker_nodes.yml"
        sh "ansible-playbook -i inventory playbooks/create_pods.yml"
        }         
    }
       
}