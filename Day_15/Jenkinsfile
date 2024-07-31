pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/neel52700/Day_15.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.build('day_15:latest')
                }
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Running tests..."'
                // Add your test commands here
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image('day_15:latest').push()
                    }
                }
            }
        }
    }
}
