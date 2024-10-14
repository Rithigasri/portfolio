pipeline {
    agent any

    environment {
        // Define your variables here
        GITHUB_REPO = 'https://github.com/Rithigasri/portfolio.git' // Replace with your GitHub repository URL
        DEPLOY_DIR = '/var/www/html' // Apache default document root
        SSH_CREDENTIALS_ID = '9e5eefe4-055a-4706-bcf4-1e8175379236' // Jenkins credentials ID for SSH
        EC2_USER = 'ubuntu' // Replace with your EC2 user if different
        EC2_HOST = '13.59.93.160' // Replace with your EC2 instance public IP
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the GitHub repository
                    git branch: 'main', url: "${GITHUB_REPO}"
                }
            }
        }

        stage('Deploy to Apache') {
            steps {
                script {
                    // Copy files to the Apache server using SSH
                    sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                        sh """
                            # Sync files to the Apache document root
                            scp -r * ${EC2_USER}@${EC2_HOST}:${DEPLOY_DIR}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
