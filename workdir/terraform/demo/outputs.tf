output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.demo_eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.demo_eks.cluster_security_group_id
}

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.demo_vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.demo_vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.demo_vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.demo_vpc.public_subnets
}
# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.demo_vpc.azs
}
