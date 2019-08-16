pipeline {
  agent {
    node {
      label 'base'
      }
  }
  stages {
    stage('build and tag image') {
      steps {
        container('base') {
          sh '''
          wget -O s2i.tar.gz https://github.com/openshift/source-to-image/releases/download/v1.1.13/source-to-image-v1.1.13-b54d75d3-linux-amd64.tar.gz \
          && tar -xvf s2i.tar.gz \
          && cp ./s2i /usr/local/bin'''
          sh './test.sh'
        }

      }
    }
    stage('docker tag') {
          when{
            branch 'master'
          }
          steps {
            container('base') {
                sh 'docker tag s2i-binary kubespheredev/s2i-binary'
            }
          }
     }
    stage('docker push') {
      when{
        branch 'master'
      }
      steps {
        container('base') {
          withCredentials([usernamePassword(passwordVariable : 'DOCKER_PASSWORD' ,usernameVariable : 'DOCKER_USERNAME' ,credentialsId : 'dockerhub-id' ,)]) {
            sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
          }
            sh 'docker push kubespheredev/s2i-binary'
        }
      }
    }
  }
}
