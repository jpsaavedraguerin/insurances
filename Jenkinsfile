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
        stage('build'){
            steps{
                sh '''
                echo "Hello World"
                '''
            }
        }
        stage('build'){
            steps{
                sh '''
                echo "Hello World"
                '''
            }
        }
        
    }
}