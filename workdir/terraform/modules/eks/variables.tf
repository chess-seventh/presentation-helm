# Cluster info
variable "cluster_name" {
  description = "The name of the cluster to be created."
  type        = string
}

variable "eks_version" {
  description = "The EKS cluster version to be used."
  type        = string
}

variable "pool_spot" {
  description = "In order to avoid forgetting to change the values"
  type        = string
  default     = "spot"
}

variable "pool_main" {
  description = "In order to avoid forgetting to change the values"
  type        = string
  default     = "main"
}

variable "worker_groups" {
  description = "Worker group and information for the cluster"
  type        = list
}

variable "worker_groups_launch_template" {
  description = "Worker group and information for the cluster"
  type        = list
}

variable "vpc_id" {
  description = "VPC ID for the new cluster"
  type        = string
}

variable "subnets" {
  description = "Subnets for the new cluster."
  type        = list
}

variable "tags" {
  description = "Cluster tags."
  type        = map
}

variable "map_roles" {
  description = "Roles to map the cluster to."
  type        = list
}

variable "map_users" {
  description = "Users to map the cluster to."
  type        = list
}

variable "map_accounts" {
  description = "Roles for K8s"
  type        = list
}

variable "aws_security_group_id" {
  description = "AWS Security Group ID"
  type        = list
}
