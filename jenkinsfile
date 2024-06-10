pipeline {
    agent any

    environment {
        GIT_REPO_URL = 'https://github.com/your-repo/your-project.git'
        GIT_BRANCH = 'main'
        AWS_REGION = 'us-west-2'
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
                script {
                    withAWS(credentials: 'aws-credentials', region: "${env.AWS_REGION}") {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    withAWS(credentials: 'aws-credentials', region: "${env.AWS_REGION}") {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Apply') {
            steps {
                script {
                    withAWS(credentials: 'aws-credentials', region: "${env.AWS_REGION}") {
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
