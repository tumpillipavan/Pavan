pipeline {
  agent any

  environment {
    IMAGE_NAME     = "pavan-docker-image"
    CONTAINER_NAME = "react_e_commerce_main"
    HOST_PORT      = "82"
    CONTAINER_PORT = "82"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build') {
      steps {
        bat "docker build -t %IMAGE_NAME% ."
      }
    }

    stage('Run') {
      steps {
        bat """
          docker rm -f %CONTAINER_NAME% 2>nul || echo No existing container to remove
          docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%:latest
        """
      }
    }

    // Remove or comment out this entire stage:
    // stage('Cleanup') {
    //   steps {
    //     bat """
    //       docker rm -f %CONTAINER_NAME% 2>nul || echo No container to stop/remove
    //       docker rmi -f %IMAGE_NAME%:latest
    //     """
    //   }
    // }
  }

  post {
    always {
      echo "Done. Your app is now running on port ${HOST_PORT}."
    }
  }
}
