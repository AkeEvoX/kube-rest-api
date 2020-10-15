pipeline{
    agent any
    environment {
        dockerImage=''
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTest clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefile-reports/*.xml'
                }
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build('dpe/kube-rest-api')
                }
            }
        }
        stage('Push image') {
            steps {
                script {
                    withDockerRegistry(
                        credentialsId: 'docker-credential',
                        url: 'https://index.docker.io/v1/') {
                            dockerImage.push()
                        }
                }
            }
        }
        stage('Deployment'){
            steps{
                sh 'kubectl apply - f deployment.yml';
            }
        }
    }
}