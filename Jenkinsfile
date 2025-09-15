pipeline {
    agent { label 'docker' }

    stages {
        stage('Build Image') {
            steps {
                echo ${env.BUILD_TAG}
                sh 'docker build -t moustiic/webstatic:v1.1 .'
            }
        }
        stage('Push Image'){
        environment{
                        DOCKER_HUB = credentials('docker-hub-creds')
                    }
            steps{
               sh 'echo ${DOCKER_HUB_PSW} | docker login -u ${DOCKER_HUB_USR} --password-stdin'
               sh "docker push moustiic/webstatic:v1.1"
            }
        }
    }
    post {
           always {
               sh 'docker logout'
           }
       }
}
