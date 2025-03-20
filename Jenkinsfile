pipeline {
    agent any

    environment {
        IMAGE_NAME = "akdt15/demo-go-ci-cd"
        DOCKER_CREDENTIALS_ID = "dockerhub_creds"
        REGISTRY_URL = "https://index.docker.io/v1/"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/akdt/demo-go-ci-cd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: REGISTRY_URL]) {
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         sh 'kubectl apply -f k8s/deployment.yaml'
        //     }
        // }
    }
}
