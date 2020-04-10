provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "1.11.1"
}

module "eks" {
  cluster_name = var.cluster_name
  subnets      = var.subnets
  vpc_id       = var.vpc_id

  source          = "terraform-aws-modules/eks/aws"
  cluster_version = var.eks_version
  version         = "8.0.0"

  cluster_endpoint_private_access = "true"
  cluster_endpoint_public_access  = "true"
  cluster_enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  cluster_create_timeout = "30m"
  cluster_delete_timeout = "30m"

  tags          = var.tags
  worker_groups = var.worker_groups

  worker_groups_launch_template = var.worker_groups_launch_template

  worker_additional_security_group_ids = var.aws_security_group_id
  map_roles                            = var.map_roles
  map_accounts                         = var.map_accounts
  map_users                            = var.map_users
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

