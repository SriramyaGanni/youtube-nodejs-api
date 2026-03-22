pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    credentialsId: 'git-creds',
                    url: 'https://github.com/SriramyaGanni/youtube-nodejs-api.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sriramyaganni/youtube-webapp:latest .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push sriramyaganni/youtube-webapp:latest'
                            }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f youtube_deployment.yml'
            }
        }
    }
}
                                  
