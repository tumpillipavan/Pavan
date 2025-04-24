pipeline {
  agent any

  environment {
    IMAGE_NAME      = "pavan-docker-image"
    CONTAINER_NAME  = "react_e_commerce_main"
    HOST_PORT       = "82"
    CONTAINER_PORT  = "82"
  }

  stages {
    stage('Build') {
      steps {
        // Build the Docker image
        bat "docker build -t %IMAGE_NAME% ."
      }
    }

    stage('Run') {
      steps {
        // Run the container in detached mode, mapping host:container port 82:82
        bat "docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%:latest"
      }
    }

    stage('Cleanup') {
      steps {
        // Stop & remove any container with this name, then remove the image
        bat """
          FOR /F "tokens=*" %%i IN ('docker ps -q -f name=%CONTAINER_NAME%') DO docker stop %%i
          FOR /F "tokens=*" %%i IN ('docker ps -a -q -f name=%CONTAINER_NAME%') DO docker rm %%i
          docker rmi %IMAGE_NAME%:latest
        """
      }
    }
  }

  post {
    always {
      echo "Pipeline finished. Check your container on port %HOST_PORT%."
    }
  }
}
