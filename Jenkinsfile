pipeline {
    agent any

    stages {
        stage('Pull from GitHub') {
            steps {
                // Pull the latest code from the GitHub repository
                git branch: 'main', url: 'https://github.com/Rithigasri/portfolio.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Perform SonarQube code analysis for static HTML
                    withSonarQubeEnv('My SonarQube Server') {
                        bat """
                        cd C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\portfolio
                        sonar-scanner -Dsonar.projectKey=poc -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqa_1c44b66f56966a23a05b74dfb2adb2960b974dea
                        """
                    }
                }
            }
        }

        stage('Deploy to IIS') {
            steps {
                script {
                    // Define the target path for IIS deployment
                    def sitePath = 'C:\\inetpub\\wwwroot\\website'
                    
                    // Ensure the target directory exists
                    bat "if not exist ${sitePath} mkdir ${sitePath}"
                    
                    // Delete existing files in the IIS directory
                    bat "del /q ${sitePath}\\*.*"
                    bat "for /d %%p in (${sitePath}\\*) do rmdir /s /q %%p"
                    
                    // Copy new files to IIS directory
                    bat "xcopy /s /e /y . ${sitePath}\\"
                    
                    // Optional: Restart IIS if necessary
                    bat 'iisreset'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
