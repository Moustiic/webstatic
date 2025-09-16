pipeline {
    environment {
        PROJECT = "moustiic"
        APP_NAME = "webstatic"
        VERSION = "v.${env.BUILD_NUMBER}"
        IMAGE_TAG_VERSION = "${PROJECT}/${APP_NAME}:${VERSION}"
        IMAGE_TAG_LATEST = "${PROJECT}/${APP_NAME}:latest"
    }
    agent { label 'docker' }

    stages {
        stage('Build Image') {
            steps {
                sh 'sed -i "s/__VERSION__/${VERSION}/g" ./html/index.html'
                sh 'sed -i "s/__VERSION__/${VERSION}/g" ./kubernetes/deployment.yaml'
                sh 'docker build -t ${IMAGE_TAG_VERSION} .'
            }
        }
        
        stage('Push Image'){
        environment{
                        DOCKER_HUB = credentials('docker-hub-creds')
                    }
            steps{
               sh 'echo ${DOCKER_HUB_PSW} | docker login -u ${DOCKER_HUB_USR} --password-stdin'
               sh "docker push ${IMAGE_TAG_VERSION}"
            }
        }

        stage('Deploy webstatic') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: 'minikube', contextName: 'minikube', credentialsId: 'minikube', namespace: 'dev', restrictKubeConfigAccess: false, serverUrl: 'https://192.168.58.2:8443') {
                    sh "minikube kubectl -- apply -f ./kubernetes/deployment.yaml"
                }
            }
        }
        
        stage('Check Deploy') {
            steps {
                sh 'sleep 5'
                sh 'curl -s 192.168.58.2:31000 |grep -q "image docker" && echo "TEST OK" || { echo "TEST KO" && exit 1; }'
                sh 'curl -s 192.168.58.2:31000 |grep -q "Version"'
            }
        }
    }
    post {
           always {
               sh 'docker logout'
           }
       }
}
