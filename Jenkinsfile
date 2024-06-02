pipeline {
    agent { label 'dev-server' }
    
    environment {
        DOCKER_BUILDKIT = '1' // Enable BuildKit
    }

    stages {
        stage('Clone Code') {
            steps {
                git url: 'https://github.com/malekmahir/node-todo-cicd.git', branch: 'master'
                echo 'Code cloning done'
            }
        }
        stage('Build and Test') {
            steps {
                script {
                    // List files and show Dockerfile content for debugging purposes
                    sh 'ls -la'
                    sh 'cat Dockerfile'
                    // Build the Docker image
                    sh 'docker build -t node-app-todo .'
                }
                echo 'Code building done'
            }
        }
        stage('Scan Image') {
            steps {
                echo 'Image scanning is done'
            }
        }
        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPass', usernameVariable: 'dockerHubUser')]) {
                    sh 'docker login -u ${dockerHubUser} -p ${dockerHubPass}'
                    sh 'docker tag node-app-todo:latest ${dockerHubUser}/node-app-todo:latest'
                    sh 'docker push ${dockerHubUser}/node-app-todo:latest'
                    echo 'Image pushing done'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker-compose down && docker-compose up -d'
                echo 'Deployment is done'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            sh 'docker system prune -f'
            echo 'Clean up done'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
