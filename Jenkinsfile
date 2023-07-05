pipeline{
    agent none
    stages{
        stage('build and push image to ecr'){
            agent{
                node{
                    label 'build-agent'
                }
            }
            stage('clone'){
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
            stage('prepare'){
                steps{
                    writeFile file: '.env', text: "${BASE_URL}"
                }
            }
            stage('build'){
                steps{
                    script{
                        app = docker.build "${env.ECR_URL}/insapphub:latest"
                    }
                }
            }
            stage('push'){
                steps{
                    script{
                        docker.withRegistry("https://${env.ECR_URL}", 'ecr:us-east-1:aws-credentials') {
                        //app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        }
                    }
                }
            }
        }

        stage('build container and run app'){
            agent{
                node{
                    label 'deploy-agent'
                }
            }
            stage('Pulling Image from ECR') {
                steps {

                    script {
                        docker.withRegistry("https://" + "${env.ECR_IMAGE_URL}", 'ecr:us-east-1:aws-credentials') {
                            sh "docker pull ${params.ECR_IMAGE_URL}"
                        }
                    }
                }
            }
        }
    }
}