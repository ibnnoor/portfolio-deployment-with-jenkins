terraform {
  backend "s3" {
    bucket  = "toyyib-remote-backend-bucket"
    key = "newstate/"
    region = "eu-central-1"
    dynamodb_table = "terraform_state"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"

  cluster_name    = "project-cluster"
  cluster_version = "1.24"
  cluster_endpoint_public_access = true
  subnet_ids      = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    first = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2

      instance_types = ["t2.micro"]
    }
  }
}
