# portfolio-deployment
A Jenkins CI/CD pipeline to deploy a portfolio webapp using terraform and kubernetes
Terraform is used to provision the infrastructure which includes EKS cluster, VPC, and Node groups to deploy the containers.
Kubernetes is used for container orchestration, for both the simple webapp that contains a portfolio and the sock shop app to describe microservice architecture.
Jenkins is used to deploy the entire service using CI/CD approach.
