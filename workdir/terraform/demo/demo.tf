terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = ">= 2.54.0"
  region  = var.region
}

# DEV VPC
module "demo_vpc" {
  source                = "../modules/vpc"
  private_subnets_range = var.private_subnets_range
  public_subnets_range  = var.public_subnets_range
  azs                   = var.azs
  cidr                  = var.cidr
  env                   = var.env
  cluster_name          = var.cluster_name
  aws_security_group_id = [aws_security_group.demo_sg.id]
}

# DEV - K8S
module "demo_eks" {
  source                        = "../modules/eks"
  cluster_name                  = var.cluster_name
  eks_version                   = var.eks_version
  subnets                       = module.demo_vpc.all_subnet_list
  vpc_id                        = module.demo_vpc.vpc_id
  tags                          = merge(local.default_cluster_tags, local.eks_cluster_tags)
  aws_security_group_id         = [aws_security_group.demo_sg.id]
  map_roles                     = var.map_roles
  map_users                     = var.map_users
  map_accounts                  = var.map_accounts
  worker_groups                 = local.worker_groups
  worker_groups_launch_template = local.worker_groups_launch_template
}

# EKS Dependencies module
module "eks_dependencies" {
  source               = "../modules/eks-dependencies"
  zone_ids             = local.zone_ids
  worker_iam_role_arn  = module.demo_eks.worker_iam_role_arn
  worker_iam_role_name = module.demo_eks.worker_iam_role_name
  cluster_name         = var.cluster_name
}

# DEV ROUTE53
module "demo_route53" {
  source       = "../modules/route53"
  domain_names = var.domain_names
}
