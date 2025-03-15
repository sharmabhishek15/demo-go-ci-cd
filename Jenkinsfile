pipeline {
    agent any

    environment {
        IMAGE_NAME = "demo-go-ci-cd"
        DOCKER_REGISTRY = "akdt15"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/sharmabhishek15/demo-go-ci-cd.git'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'go mod tidy'
                sh 'go build -o demo-go-ci-cd ./cmd/server'
                sh 'go test ./...'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
