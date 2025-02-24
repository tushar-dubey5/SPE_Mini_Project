pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'calculator-app'
        GITHUB_REPO_URL = 'https://github.com/tushar-dubey5/SPE_Mini_Project.git'
        DOCKER_HUB_CREDENTIALS = credentials('docker_hub_credentials')  // Ensure this ID exists in Jenkins
        DOCKER_HUB_USERNAME = 'tushar542001'  
    }

    stages {
        stage('Clone Git') {
            steps {
                git branch: 'main', url: "${GITHUB_REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}", '.')
                }
            }
        }

        stage('Run Tests in Docker') {
            steps {
                script {
                    sh "docker run --rm ${DOCKER_IMAGE_NAME} python3 test_calculator.py"
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {  // Corrected
                        sh "docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:latest"
                        sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    ansiblePlaybook(
                        playbook: 'deploy.yml',
                        inventory: 'inventory'
                    )
                }
            }
        }
    } 
}
