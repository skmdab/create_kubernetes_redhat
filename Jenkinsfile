pipeline{

    agent any

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '2')
    }


    stages{
        stage('Checkout the code'){
            steps{
                git branch: 'testing', url: 'https://github.com/skmdab/create_kubernetes_redhat.git'
            }
        }

        stage('Creating K8s Server'){
            steps{
                sh "sh aws_create.sh"
            }

        stage('Echo Public IP'){
            steps{
                sh "echo '$PUBLICIP'"
            }
        }

    }
}

