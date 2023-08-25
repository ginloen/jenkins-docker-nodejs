pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                 sh 'git clone https://github.com/johnpapa/node-hello.git'
            }
        }
        stage('Git checkout Dockerfile') {
            steps {
                dir('node-hello') {
                    sh 'git clone https://github.com/ginloen/jenkins-docker-nodejs.git'
                }
            }
        }
        stage('Docker build') {
            steps {
                dir('node-hello') {
                    sh 'docker build -t samplenodeapp -f ${WORKSPACE}/node-hello/jenkins-docker-nodejs/Dockerfile .'
                }
            }
        }
        stage('Run docker container') {
            steps {
                sh 'docker run -d -p 80:3000 samplenodeapp'
            }
        }              
    }
    post { 
        always { 
            cleanWs()
        }
}

