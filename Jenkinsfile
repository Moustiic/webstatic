pipeline {
    environment {
        PROJECT = "moustiic"
        APP_NAME = "webstatic"
        IMAGE_TAG = "${PROJECT}/${APP_NAME}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    }
    agent { label 'docker' }

    stages {
        stage('Build Image') {
            steps {
                echo "${env.DEPLOY_VERSION}"
                sh 'docker build -t ${IMAGE_TAG} .'
            }
        }
        stage('Push Image'){
        environment{
                        DOCKER_HUB = credentials('docker-hub-creds')
                    }
            steps{
               sh 'echo ${DOCKER_HUB_PSW} | docker login -u ${DOCKER_HUB_USR} --password-stdin'
               sh "docker push ${IMAGE_TAG}"
            }
        }
    }
    post {
           always {
               sh 'docker logout'
           }
       }
}
