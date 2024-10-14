pipeline {
    agent any

    environment {
        // Define your variables here
        GITHUB_REPO = 'https://github.com/Rithigasri/portfolio.git' // Replace with your GitHub repository URL
        DEPLOY_DIR = '/var/www/html' // Apache default document root
        EC2_USER = 'ubuntu' // Replace with your EC2 user if different
        EC2_HOST = '13.59.93.160' // Replace with your EC2 instance public IP
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the GitHub repository
                    echo "Cloning repository from ${GITHUB_REPO}..."
                    git branch: 'main', url: "${GITHUB_REPO}"
                }
            }
        }

        stage('Grant Sudo Privileges to Jenkins') {
            steps {
                script {
                    // Grant sudo privileges to Jenkins user
                    echo "Granting sudo privileges to Jenkins user..."
                    sh """
                    echo "jenkins ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/jenkins > /dev/null
                    sudo chmod 440 /etc/sudoers.d/jenkins
                    """
                    echo "Sudo privileges granted to Jenkins user without password."
                }
            }
        }

        stage('Deploy to Apache') {
            steps {
                script {
                    // Deploy the files to the Apache server
                    echo "Deploying to Apache server at ${EC2_HOST}..."
                    sh """
                    sudo chown -R www-data:www-data ${DEPLOY_DIR}
                    sudo chmod -R 755 ${DEPLOY_DIR}
                    sudo cp -r * ${DEPLOY_DIR}/
                    echo "Deployment to Apache completed successfully."
                    """
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
