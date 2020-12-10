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
            sshPublisher(
              continueOnError: false, 
              failOnError: true,
              publishers: [
                sshPublisherDesc(
                  configName: "ansible-master",
                  transfers: [sshTransfer(sourceFiles: "Dockerfile"),
                            sshTransfer(remoteDirectory: "/home/osboxes")],
                  verbose: true
                )
              ]
           )
          }
       
    }    
  }
}