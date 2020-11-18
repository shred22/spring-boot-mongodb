pipeline {
  agent {
        docker {
            image 'maven:3-alpine'
            args '-v $HOME/.m2:/root/.m2'
        }
    }

    options { buildDiscarder(logRotator(numToKeepStr: '5')) }

    parameters {
            string(name: 'ansible_branch', defaultValue: 'master', description: 'Which Ansible branch to use for reading template vars ?')
            string(name: 'push_to_dockerhub', defaultValue: 'N', description: 'Push this build\'s image to Docker hub Y or N ?')
    }

    stages {

        stage('Build With Unit Tests') {
          steps {
            script {
             myImage = docker.image("shred22/docker-productservice:1.0")
                        myImage.build()
                        myImage.push()
            }
          }

         }

       /*  stage('Integration Test') {
             steps {
                  configFileProvider([configFile(fileId: "maven-settings-file", variable: 'MAVEN_SETTINGS')]) {
                       sh 'mvn clean test -DskipTests'
                  }

             }
        }
        stage('Push Docker Image') {
                       steps {
                         script {
                                if("${params.push_to_dockerhub}" == 'Y') {
                                 withCredentials([usernamePassword(
                                        credentialsId: 'DockerHub',
                                        usernameVariable: 'DOCKER_USERNAME',
                                        passwordVariable: 'DOCKER_PASSWORD',
                                    )]) {
                                        sh 'docker login --username="${DOCKER_USERNAME}" --password="${DOCKER_PASSWORD}"'
                                    }
                                   configFileProvider([configFile(fileId: "maven-settings-file", variable: 'MAVEN_SETTINGS')]) {
                                          sh "mvn install -DskipTests -Ppush-docker-image -s $MAVEN_SETTINGS"

                                   }
                             }

                         }
                       }
                }
    } */
}
}
