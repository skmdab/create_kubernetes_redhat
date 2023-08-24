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
                    def PUBLIC_IP = sh(script: '/root/.jenkins/workspace/k8s/aws_create.sh', returnStatus: true)
                    echo "Script output: ${PUBLIC_IP}"
                }
            }
        }

        stage('Coping script to remote'){
            steps{
                environment.PUBLIC_IP = PUBLIC_IP
                withCredentials([file(credentialsId: 'pemfile', variable: 'PEMFILE')]) {
                      sh "scp -i $PEMFILE /root/.jenkins/workspace/k8s/k8s.sh ec2-user@${PUBLIC_IP}:"
		            }
                }
            }
        }
    }

