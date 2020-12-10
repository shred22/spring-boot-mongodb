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
        steps([$class: 'BapSshPromotionPublisherPlugin']) {
            sshPublisher(
                continueOnError: false, failOnError: true,
                publishers: [
                    sshPublisherDesc(
                        configName: "ansible-master",
                        verbose: true,
                        transfers: [
                            //sshTransfer(execCommand: "/bin/rm -rf /opt/deploy/helm"),
                            sshTransfer(sourceFiles: "Dockerfile","docker-compose.yaml"),
                            sshTransfer(remoteDirectory: "/home/osboxes")
                            
                        ]
                    )
                ]
            )
        }
    }
    
  }
}