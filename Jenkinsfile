#!groovy

pipeline {
  agent none
  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.5.0'
        }
      }
      steps {
        sh 'mvn clean install -DskipTests'
      }
    }
    stage('Docker Build') {
      agent any
      steps {
        sh 'docker build -t shred22/docker-productservice:latest .'
      }
    }
      stage('SSH transfer to Ansible Controller Node') {
        agent any
          steps([$class: 'BapSshPromotionPublisherPlugin']) {
          sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible-master', 
          transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd //home/osboxes/Ansible docker-compose build
          docker-compose up''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', 
          remoteDirectory: '//home//osboxes//Ansible', 
          remoteDirectorySDF: false, removePrefix: '', 
          sourceFiles: 'Dockerfile,docker-compose.yaml')], 
          usePromotionTimestamp: false, 
          useWorkspaceInPromotion: false, 
          verbose: true)])
          }
    }    
  }
}