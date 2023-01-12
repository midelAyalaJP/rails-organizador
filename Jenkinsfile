pipeline {
  agent any

  options {
    timeout(time: 5, unit: 'MINUTES')
  }
  tools {
    nodejs 'node-16.17.0'
  }

  stages {
    stage('Create container') {
      steps {
        script {
            sh "docker build -t deleteme ."
        }
      }
    }
    stage('Run tests') {
      steps {
        sh '''
            echo "todo tests"
        '''
        
      }
    }
    stage('Run') {
      steps {
        sh '''
            docker run --rm -p -d 3000:3000 deleteme
        '''
        
      }
    }
    
  }
}