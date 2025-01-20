@Library('shared-library') _
pipeline {
    
    agent {label 'DockerNode'}

    stages {
        stage('Code clone') {
            steps {
                code_clone('github_credentials', 'https://github.com/PoojaPrakash27/Two-Tier-App.git', 'master')
            }
        }
        stage('Code build') {
            steps {
                code_build('two-tier-app', 'v1')
            }
        }
        stage('Push image to DockerHub') {
            steps {
                push_to_dockerhub('two-tier-app', 'v1')
            }
        }
        stage('Code Deploy') {
            steps {
                code_deploy()
                echo 'code deployed'
            }
        }
    }
}