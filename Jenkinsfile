pipeline {
    agent any

    environment {
        GIT_REPO_URL = 'https://github.com/UtsavsmSharma/Terrafor-infra.git'
        GIT_BRANCH = 'main'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                git url: "${env.GIT_REPO_URL}", branch: "${env.GIT_BRANCH}"
            }
        }

        stage('Init') {
            steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'jenkins', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    // some block
                sh  ' terraform init '               
        
        } 
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    withAWS(credentials: 'jenkins', region: "${env.AWS_REGION}") {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Apply') {
            steps {
                script {
                    withAWS(credentials: jenkins', region: "${env.AWS_REGION}") {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Infrastructure applied successfully!'
        }
        failure {
            echo 'There was an error in applying the infrastructure.'
        }
    }
}
