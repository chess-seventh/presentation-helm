variable "region" {
  description = "The region from which this module will be executed"
  type        = string
  default     = "eu-west-1"
}

variable "eks_version" {
  description = "The region from which this module will be executed"
  type        = string
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  default = [
    "730065269158"
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = list

  default = []
}

variable "map_users" {
  type = list
  default = []
}

variable "cluster_name" {
  type = string
}

variable "domain_names" {
  type = map
}

variable "all_subnet_list" {
  type = list
}

variable "private_subnets_range" {
  type = list
}

variable "public_subnets_range" {
  type = list
}

variable "azs" {
  type    = list
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "cidr" {
  type = string
}

variable "env" {
  type = string
}

variable "spot_max_price" {
  type    = string
  default = "0"
}

variable "asg_max_size_spot" {
  default = 0
}
variable "asg_min_size_spot" {
  default = 0
}

variable "asg_desired_capacity_spot" {
  default = 0
}

variable "asg_max_size_main" {
  default = 0
}

variable "asg_min_size_main" {
  default = 0
}

variable "asg_desired_capacity_main" {
  default = 0
}

