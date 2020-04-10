variable "private_subnets_range" {
  description = "List of private subnets"
  type        = list
}

variable "public_subnets_range" {
  description = "List of public subnets"
  type        = list
}

variable "azs" {
  description = "List of AZS"
  type        = list
}

variable "cidr" {
  description = "Classless Inter-Domain Routing,"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "aws_security_group_id" {
  type = list
}

variable "public_dedicated_network_acl" {
  type    = bool
  default = false
}

variable "private_dedicated_network_acl" {
  type    = bool
  default = false
}

variable "public_inbound_acl_rules" {
  type    = list
  default = []
}

variable "public_outbound_acl_rules" {
  type    = list
  default = []
}

variable "private_inbound_acl_rules" {
  type    = list
  default = []
}

variable "private_outbound_acl_rules" {
  type    = list
  default = []
}

variable "propagate_public" {
  type    = bool
  default = false
}

variable "propagate_private" {
  type    = bool
  default = false
}
