pipeline{

    agent any

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '2')
    }

    environment {
        PUBLIC_IP = "" // Initialize the environment variable
    }

    stages{
        stage('Checkout the code'){
            steps{
                git branch: 'testing', url: 'https://github.com/skmdab/create_kubernetes_redhat.git'
            }
        }

        stage('Creating K8s Server'){
            steps{
                script {
                    // Run a shell script and capture its output
                    def PUBLIC_IP = sh(script: '/root/.jenkins/workspace/k8s/aws_create.sh', returnStatus: true).trim()
                }
            }
        }
    }
}

