pipeline {
    agent any

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Docker image
                    bat 'docker build -t pavan-docker-image .'
                }
            }
        }

        stage('Run') {
            steps {
                script {
                    // Run the Docker container in detached mode and map port 82
                    bat 'docker run -d -p 82:82 --name react_e_commerce_main pavan-docker-image:latest'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Stop the running container
                    bat 'FOR /F "tokens=*" %i IN (\'docker ps -q -f name=react_e_commerce_main\') DO docker stop %i'
                    // Remove the container
                    bat 'FOR /F "tokens=*" %i IN (\'docker ps -a -q -f name=react_e_commerce_main\') DO docker rm %i'
                    // Force remove the Docker image
                    bat 'docker rmi -f pavan-docker-image:latest'
                }
            }
        }

        stage('Declarative: Post Actions') {
            steps {
                echo 'Pipeline finished. Check your container on port %HOST_PORT%.'
            }
        }
    }
}
