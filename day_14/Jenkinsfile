pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockercrd') // Add your DockerHub credentials ID in Jenkins
        DOCKERHUB_REPO = 'neelpatel5270/day14_project' // Your DockerHub repository
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/neel52700/Day14_Project.git' // Your GitHub repository URL
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("$DOCKERHUB_REPO:latest")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKERHUB_CREDENTIALS') {
                        docker.image("$DOCKERHUB_REPO:latest").push()
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    sh 'docker run -d --name day14_project -p 8080:8080 neelpatel5270/day14_project:latest' // Adjust port mapping as necessary
                }
            }
        }
    }
}
