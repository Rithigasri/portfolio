provider "local" {
  # Local provider for Terraform
}

resource "local_file" "jenkins_pipeline_script" {
  content = <<-EOT
    pipeline {
        agent any

        stages {
            stage('Checkout') {
                steps {
                    git url: 'https://github.com/Rithigasri/portfolio.git', branch: 'main'
                }
            }

            stage('Build') {
                steps {
                    // Replace with your build commands, e.g., mvn clean install for Maven projects
                    sh 'echo Building project...'
                }
            }

            stage('Deploy') {
                steps {
                    // Deployment commands, e.g., copying files to a web server directory
                    sh 'echo Deploying project...'
                }
            }

            stage('Health Check') {
                steps {
                    sh '''
                        STATUS=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:8080)
                        if [ "$STATUS" -ne 200 ]; then
                            echo "Website is down! Status code: $STATUS"
                            exit 1
                        else
                            echo "Website is up and running!"
                        fi
                    '''
                }
            }
        }
    }
  EOT

  filename = "jenkins_pipeline.groovy"
}

resource "null_resource" "jenkins_job" {
  provisioner "local-exec" {
    command = <<-EOT
      # Use Jenkins CLI to create a job with the above pipeline script
      java -jar /path/to/jenkins-cli.jar -s http://localhost:8080/ create-job "MyGitHubJob" < jenkins_pipeline.groovy
    EOT
  }

  depends_on = [local_file.jenkins_pipeline_script]
}
