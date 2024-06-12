pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your version control
                git branch: 'main', credentialsId: 'a230f463-14da-408a-b511-4444cf2977fc', url: 'https://github.com/UtsavsmSharma/Terrafor-infra.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                // Initialize Terraform with automated "yes" response
                sh 'echo yes | terraform init'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                // Apply the Terraform plan with auto-approve
                sh 'terraform apply --auto-approve'
            }
        }
        
        stage('Terraform Destroy') {
            steps {
                // Destroy the Terraform-managed infrastructure with auto-approve
                sh 'terraform $action --auto-approve'
            }
        }
    }
}
