pipeline {
    agent any
    
    stages {
        stage("checkout from GIT") {
            steps {
                git branch: 'main', credentialsId: 'a230f463-14da-408a-b511-4444cf2977fc', url: 'https://github.com/UtsavsmSharma/Terrafor-infra.git' 
            } 
        }
        stage('Install Terraform') {
            steps {
                script {
                    def terraformVersion = '1.3.1'
                    sh "wget https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip"
                    sh "unzip -o terraform_${terraformVersion}_linux_amd64.zip"
                    sh 'chmod +x terraform'
                    sh ' whoami'
                    sh 'sudo mv terraform /usr/local/bin/terraform'
                    sh 'terraform version'
                }
            }
        }
        
        stage("terraform init") {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
    }
}
