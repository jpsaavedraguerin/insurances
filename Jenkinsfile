pipeline{
    agent{
        node{
            label 'build-agent'
        }
    }
    stages{
        stage('clone'){
            steps{
                git branch: "master"
                url: "https://github.com/jpsaavedraguerin/insirances.git"
            }
        }
        stage('test'){
            steps{
                sh '''
                echo "Hello World"
                '''
            }
        }
        
    }
}