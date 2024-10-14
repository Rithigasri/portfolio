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
            echo "Sudo privileges should now be granted without a password."
        }
    }
}


        sstage('Deploy to Apache') {
    steps {
        script {
            // Change ownership and permissions
            sh '''
                sudo chown -R www-data:www-data /var/www/html
                sudo chmod -R 755 /var/www/html
                sudo cp -r * /var/www/html/
                echo "Deployment to Apache completed successfully."
            '''
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
