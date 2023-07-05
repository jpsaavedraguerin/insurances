pipeline{
    agent none
    stages{
        stage('Clone'){
            agent{
                node{
                    label 'build-agent'
                }
            }
            steps{
                script{
                    git branch: 'master', url: 'https://github.com/jpsaavedraguerin/insurances.git'
                    // make sure
                    sh "ls -lart ./*" 
                    // List all branches 
                    sh "git branch -a"
                    // Checkout to master
                    sh "git checkout master"
                }                
            }
        }
        stage('Prepare'){
            agent{
                node{
                    label 'build-agent'
                }
            }
            steps{
                writeFile file: '.env', text: "${BASE_URL}"
            }
        }
        stage('Build'){
            agent{
                node{
                    label 'build-agent'
                }
            }
            steps{
                script{
                    app = docker.build "${env.ECR_URL}/insapphub:latest"
                }
            }
        }
        stage('Push'){
            agent{
                node{
                    label 'build-agent'
                }
            }
            steps{
                script{
                    docker.withRegistry("https://${env.ECR_URL}", 'ecr:us-east-1:aws-credentials') {
                    //app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
        stage('Pulling Image from ECR') {
            agent{
                node{
                    label 'deploy-agent'
                }
            }
            steps {

                script {
                    docker.withRegistry("https://" + "${env.ECR_URL}", 'ecr:us-east-1:aws-credentials') {
                        sh "docker pull ${env.ECR_URL}/insapphub:latest"
                    }
                }
            }
        }
        stage('Run container app') {
            agent{
                node{
                    label 'deploy-agent'
                }
            }
            steps {
                sh 'sudo docker-compose up'
            }
        }
    }
}
