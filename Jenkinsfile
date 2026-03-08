pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "sriramyaganni/youtube-webapp:v1"
        DOCKER_CREDENTIALS = credentials('docker-hub')
    }

    stages {

        stage('Checkout') {
            steps {
   		checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'Sriramya', url: 'https://github.com/SriramyaGanni/youtube-nodejs-api.git']])
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
i
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/']) {
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy Local Container') {
            steps {
                sh """
                docker rm -f youtube-api || true
                docker run -d --name youtube-api -p 3000:8080 ${DOCKER_IMAGE}
                """
            }
        }
    }
}
