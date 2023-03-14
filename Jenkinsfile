#!/usr/bin/env groovy

pipeline {
    agent any
    environment {
        aws_access_key_id = credentials('AWS_ACCESS_KEY_ID')
        aws_secret_key_access = credentials('AWS_SECRET_ACCESS_KEY')
        aws_default_region = "eu-central-1"
    }

    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init -backend-config="access_key=AKIATVPYMU32T7YDNG6A" -backend-config="E1PDDe9Ou3pGrRSZwkJTgWEnYsd75ROMmq6MQyMl""
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name project-cluster"
                        sh "kubectl apply -f webapp-deployment.yaml"
                        sh "kubectl apply webapp-service.yaml"
                    }
                }
            }
        }
    }
}
