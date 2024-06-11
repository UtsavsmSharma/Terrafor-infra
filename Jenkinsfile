pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/example/repository.git', branch: 'main'
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}
