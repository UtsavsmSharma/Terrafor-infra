pipeline {
    agent any
    
    stages {
        stage("checkout from GIT") {
            steps {
                git branch: 'main', credentialsId: 'a230f463-14da-408a-b511-4444cf2977fc', url: 'https://github.com/UtsavsmSharma/Terrafor-infra.git' 
            } 
        }
        
        stage("terraform init") {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage("terraform apply") {
            steps {
                script {
                    def userInput = input(
                        id: 'terraform-apply-input',
                        message: 'Do you want to apply Terraform changes?',
                        parameters: [
                            [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Proceed with Terraform apply?']
                        ]
                    )
                    
                    if (userInput) {
                        sh 'terraform apply --auto-approve'
                    } else {
                        echo 'Terraform apply skipped.'
                    }
                }
            }
        }
    }
}
