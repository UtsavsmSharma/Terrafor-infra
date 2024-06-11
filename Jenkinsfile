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
                    def userInput = input(
                        id: 'confirmTerraformInstall',
                        message: 'Do you want to install Terraform? (yes/no)',
                        parameters: [
                            choice(choices: ['yes', 'no'], description: '')
                        ]
                    )
                    if (userInput == 'yes') {
                        def terraformVersion = '1.3.1'
                        sh "wget https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip"
                        sh "unzip -o terraform_${terraformVersion}_linux_amd64.zip"
                        sh 'chmod +x terraform'
                        sh 'sudo mv terraform /usr/local/bin/terraform'
                        sh 'terraform version'
                    } else {
                        echo 'Terraform installation skipped.'
                    }
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
        
        stage("terraform plan") {
            steps {
                script {
                    def userInput = input(
                        id: 'confirmTerraformPlan',
                        message: 'Do you want to run "terraform plan"? (yes/no)',
                        parameters: [
                            choice(choices: ['yes', 'no'], description: '')
                        ]
                    )
                    if (userInput == 'yes') {
                        sh 'terraform plan'
                    } else {
                        echo 'Terraform plan skipped.'
                    }
                }
            }
        }
        
        stage("terraform apply") {
            steps {
                script {
                    def userInput = input(
                        id: 'confirmTerraformApply',
                        message: 'Do you want to apply the Terraform changes? (yes/no)',
                        parameters: [
                            choice(choices: ['yes', 'no'], description: '')
                        ]
                    )
                    if (userInput == 'yes') {
                        sh 'terraform apply'
                    } else {
                        echo 'Terraform apply skipped.'
                    }
                }
            }
        }
    }
}
