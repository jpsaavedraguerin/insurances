pipeline{
    agent{
        node{
            label 'build-agent'
        }
    }
    stages{
        stage('test'){
            steps{
                sh '''
                echo "Hello World"
                '''
            }
        }
        
    }
}