#!/usr/bin/env groovy

pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        aws_default_region = "eu-central-1"
    }

    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "KUBECONFIG=./../terraform/kubeconfig_portfolio kubectl apply -f webapp-deployment.yaml"
                        sh "KUBECONFIG=./../terraform kubeconfig_portfolio kubectl apply webapp-service.yaml"
                    }
                }
            }
        }
    }
}
