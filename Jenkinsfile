pipeline {
    agent { label "dev-server"}
    
    stages {
        
        stage("code"){
            steps{
                git url: "https://github.com/malekmahir/node-todo-cicd.git", branch: "master"
                echo 'Code cloning done'
            }
        }
        stage("build and test"){
            steps{
                sh "docker build -t node-app-todo ."
                echo 'code building done'
            }
        }
        stage("scan image"){
            steps{
                echo 'image scanning is done'
            }
        }
        stage("push"){
            steps{
                withCredentials([usernamePassword(credentialsId:"dockerHub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker tag node-app-todo:latest ${env.dockerHubUser}/node-app-todo:latest"
                sh "docker push ${env.dockerHubUser}/node-app-test-todo:latest"
                echo 'image pushing done'
                }
            }
        }
        stage("deploy"){
            steps{
                sh "docker-compose down && docker-compose up -d"
                echo 'deployment is done'
                echo 'Thanks'
            }
        }
    }
}
