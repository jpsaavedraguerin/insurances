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
                sh '''
                docker build -t insapp:latest .
                '''
            }
        }
        stage('push'){
            steps{
                sh '''
                echo "Hello World"
                '''
            }
        }
        
    }
}