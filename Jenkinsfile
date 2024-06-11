pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    git branch: 'main', credentialsId: 'a230f463-14da-408a-b511-4444cf2977fc', url: 'https://github.com/example/repository.git'
                }
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
