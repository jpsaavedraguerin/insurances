pipeline{
    agent{
        node{
            label 'build-agent'
        }
    }
    stages{
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
                    docker.build '$ECR_URL/insapphub:latest'
                }
            }
        }
        stage('push'){
            steps{
                script{
                    docker.withRegistry("${env.ECR_URL}", 'ecr:us-east-1:aws-credentials') {
                    //app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                }
            }
        }
        
    }
}