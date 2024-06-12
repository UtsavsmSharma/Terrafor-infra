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
                // Prompt for user input before running terraform init
                script {
                    def userInput = input(id: 'UserInput', message: 'Do you want to run terraform init?', parameters: [choice(name: 'Confirm', choices: ['yes', 'no'], description: 'Please select')])
                    if (userInput == 'yes') {
                        sh 'terraform init'
                    } else {
                        echo 'Skipping terraform init as per user request.'
                    }
                }
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
