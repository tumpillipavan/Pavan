pipeline {
    agent any

    environment {
        IMAGE_NAME = "pavan-docker-image"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile in the repository
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container in detached mode, exposing port 3000
                    dockerImage.run("-d -p 3000:3000")
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Stop and remove the running container
                    sh 'docker ps -q -f "name=${IMAGE_NAME}" | xargs -r docker stop | xargs -r docker rm'
                    // Remove the built image to free up space
                    sh 'docker rmi ${IMAGE_NAME}'
                }
            }
        }
    }
}
