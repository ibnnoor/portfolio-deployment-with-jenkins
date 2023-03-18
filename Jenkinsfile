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
        stage("Set the environment variable") {
            steps {
                script {
                    dir('terraform') {
                        sh 'export KUBECONFIG="/var/lib/jenkins/workspace/final-pipeline/terraform/kubeconfig_portfolio"'
                    }
                }
            }
        }

        stage("Deploy the webapp to the EKS Cluster") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "kubectl apply -f webapp-deployment.yaml"
                        sh "kubectl apply -f webapp-service.yaml"
                        sh "kubectl apply -f postgres-deployment.yaml"
                        sh "kubectl apply -f postgres-service.yaml"
                    }
                }
            }
        }
        stage("Deploy the microshop to the EKS Cluster") {
            steps {
                script {
                    dir('microservices-demo/deploy/kubernetes') {
                        sh "kubectl apply -f complete-demo.yaml"
                    }
                }
            }
        }

    }
}
