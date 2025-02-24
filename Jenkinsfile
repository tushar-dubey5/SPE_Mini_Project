pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'calculator-app'
        GITHUB_REPO_URL = 'https://github.com/tushar-dubey5/SPE_Mini_Project.git'
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
                    sh 'docker run --rm ${DOCKER_IMAGE_NAME} python3 test_calculator.py'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', 'DockerHubCred') {
                        sh 'docker tag calculator-app mydockerhub/calculator-app:latest'
                        sh 'docker push mydockerhub/calculator-app'
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
