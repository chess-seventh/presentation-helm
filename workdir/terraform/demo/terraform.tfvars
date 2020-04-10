## Global variables
cluster_name = "demo"
env          = "demo"

# Add here any domain names for this cluster
domain_names = {
  "demo" : "rootbytes.net"
}

## VPC variables
private_subnets_range = ["172.30.1.0/24", "172.30.2.0/24", "172.30.3.0/24"]
public_subnets_range  = ["172.30.101.0/24", "172.30.102.0/24", "172.30.103.0/24"]
all_subnet_list       = ["173.30.1.0/24", "172.30.2.0/24", "172.30.3.0/24", "172.30.101.0/24", "172.30.102.0/24", "172.30.103.0/24"]
azs                   = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
cidr                  = "172.30.0.0/16"

## EKS related variables
eks_version = "1.14"

# On demand instances
asg_max_size_main         = 0
asg_min_size_main         = 0
asg_desired_capacity_main = 0

# Spot instances
asg_max_size_spot         = 5
asg_min_size_spot         = 1
asg_desired_capacity_spot = 3

spot_max_price = "0.114"
