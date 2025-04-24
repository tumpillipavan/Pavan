pipeline {
    agent any

    environment {
        IMAGE_NAME = "pavan-docker-image"  // Name for the Docker image
    }

    stages {
        // Stage 1: Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile in the repository
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        // Stage 2: Run Docker Container
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container in detached mode, exposing port 82
                    dockerImage.run("-d -p 82:82 --name react_e_commerce_main")
                }
            }
        }

        // Stage 3: Cleanup
        stage('Cleanup') {
            steps {
                script {
                    // Stop and remove the running container
                    sh 'docker ps -q -f "name=react_e_commerce_main" | xargs -r docker stop | xargs -r docker rm'
                    // Remove the built image to free up space
                    sh 'docker rmi ${IMAGE_NAME}'
                }
            }
        }
    }
}
