pipeline {
  agent any

  environment {
    IMAGE_NAME      = "pavan-docker-image"
    CONTAINER_NAME  = "react_e_commerce_main"
    HOST_PORT       = "82"
    CONTAINER_PORT  = "82"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        // Build the Docker image
        bat "docker build -t %IMAGE_NAME% ."
      }
    }

    stage('Run') {
      steps {
        // Remove any old container with this name, then start a fresh one
        bat """
          docker rm -f %CONTAINER_NAME% 2>nul || echo No existing container to remove
          docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%:latest
        """
      }
    }

    stage('Cleanup') {
      steps {
        // Stop & remove the container, then force-remove the image
        bat """
          docker rm -f %CONTAINER_NAME% 2>nul || echo No container to stop/remove
          docker rmi -f %IMAGE_NAME%:latest
        """
      }
    }
  }

  post {
    always {
      echo "Pipeline completed. Your app should now be running on port ${HOST_PORT} (if you skipped cleanup)."
    }
  }
}
