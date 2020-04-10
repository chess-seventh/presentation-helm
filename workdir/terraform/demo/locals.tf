locals {
  worker_groups = []
  worker_groups_launch_template = [
    {
      asg_desired_capacity = "${var.asg_desired_capacity_spot}"
      asg_max_size         = "${var.asg_max_size_spot}"
      asg_min_size         = "${var.asg_min_size_spot}"
      name                 = "spot-pool"
      autoscaling_enabled  = true
      enable_monitoring    = true

      # We want same instances (but as spot) as in Production env.
      instance_type       = "t2.large"
      spot_instance_pools = 3
      subnets             = "${module.demo_vpc.private_subnets}"

      spot_max_price = "${var.spot_max_price}"

      pre_userdata         = "${data.template_file.pre_user_data.rendered}"
      kubelet_extra_args   = "--node-labels=kubernetes.io/lifecycle=spot --node-labels=cluster=${var.cluster_name} --kube-reserved cpu=250m,memory=1Gi,ephemeral-storage=1Gi --system-reserved cpu=250m,memory=1Gi,ephemeral-storage=1Gi --eviction-hard memory.available<100Mi,nodefs.available<10%"
      bootstrap_extra_args = ""
      additional_userdata  = ""

      enabled_metrics = [
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupMaxSize",
        "GroupMinSize",
        "GroupPendingInstances",
        "GroupStandbyInstances",
        "GroupTerminatingInstances",
        "GroupTotalInstances",
      ]
      lifecycle = {
        create_before_destroy = true
      }
    },
  ]

  default_cluster_tags = {
    "terraform"   = "true"
    "production"  = "false"
    "environment" = "${var.env}"
  }

  eks_cluster_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/lifecycle"                   = "spot"
  }

  zone_ids = [
    for zone_id in "${module.demo_route53.secondary_zone_ids}" :
    "\"arn:aws:route53:::hostedzone/${zone_id}\""
  ]
  ddb_locking_table = "lock-${var.cluster_name}"

}

