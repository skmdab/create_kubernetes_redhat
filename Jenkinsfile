pipeline{

    agent any

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '2')
    }


    stages{
        stage('Checkout the code'){
            steps{
                git branch: 'master', url: 'https://github.com/skmdab/create_Kubernetes.git'
            }
        }

        stage('Creating K8s Server'){
            steps{
                sh "sh aws_create.sh"
            }
        }

        stage('Getting Public IP of Created Instance'){
            steps{
                sh "PUBLICIP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=master" --query "Reservations[0].Instances[0].PublicIpAddress" --output text)"

            }
        }

    }
}

