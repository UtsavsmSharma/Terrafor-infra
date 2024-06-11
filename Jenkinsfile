pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'a230f463-14da-408a-b511-4444cf2977fc', url: 'https://github.com/UtsavsmSharma/Terrafor-infra.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'echo yes |terraform init '
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        stage(terraform destroy ){
        steps{
 
         sh 'terraform destroy --autoapprove'

        }
        }
    }
}