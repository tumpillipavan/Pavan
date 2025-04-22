pipeline {
    agent any

    environment {
        IMAGE_NAME = "pavan-docker-image"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/tumpillipavan/Pavan.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    dockerImage.run("-d -p 3000:3000")
                }
            }
        }
    }
}
