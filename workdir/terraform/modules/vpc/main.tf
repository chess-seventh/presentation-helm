module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.env}"
  cidr = var.cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs                              = var.azs
  private_subnets                  = var.private_subnets_range
  public_subnets                   = var.public_subnets_range
  default_vpc_enable_dns_hostnames = true

  # VPC Endpoint for EC2
  enable_ec2_endpoint              = false
  ec2_endpoint_private_dns_enabled = false
  ec2_endpoint_security_group_ids  = []

  # VPC Endpoint for ECR DKR
  enable_ecr_dkr_endpoint              = false
  ecr_dkr_endpoint_private_dns_enabled = false
  ecr_dkr_endpoint_security_group_ids  = []

  enable_nat_gateway = true
  single_nat_gateway = true

  public_dedicated_network_acl  = var.public_dedicated_network_acl
  private_dedicated_network_acl = var.private_dedicated_network_acl

  public_inbound_acl_rules   = var.public_inbound_acl_rules
  public_outbound_acl_rules  = var.public_outbound_acl_rules
  private_inbound_acl_rules  = var.private_inbound_acl_rules
  private_outbound_acl_rules = var.private_outbound_acl_rules

  propagate_private_route_tables_vgw = var.propagate_private
  propagate_public_route_tables_vgw  = var.propagate_public

  tags = {
    Terraform   = "true"
    Environment = var.env
  }

  vpc_tags = {
    Name                                        = "vpc-${var.env}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
