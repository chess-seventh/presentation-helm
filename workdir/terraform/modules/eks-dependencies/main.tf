# Cert Manager
resource "aws_iam_role" "cert-manager-role" {
  name               = "cert-manager-${var.cluster_name}"
  description        = "Allows EC2 instances to call AWS services on your behalf."
  assume_role_policy = data.template_file.policy-assume-role.rendered
}

resource "aws_iam_policy" "cert-manager-policy" {
  name        = "cert-manager-${var.cluster_name}"
  description = "Policy to authorize Route53 actions."
  policy      = data.template_file.policy-cert-manager.rendered
}

resource "aws_iam_role_policy_attachment" "cert-manager-role-policy-attachment" {
  role       = aws_iam_role.cert-manager-role.name
  policy_arn = aws_iam_policy.cert-manager-policy.arn
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "cert-manager-attach-ec2" {
  role       = var.worker_iam_role_name
  policy_arn = aws_iam_policy.cert-manager-policy.arn

  lifecycle {
    create_before_destroy = true
  }
}

# External DNS
resource "aws_iam_policy" "external-dns" {
  name        = "external-dns-${var.cluster_name}"
  description = "Permissions for external-dns"
  policy      = data.template_file.policy-external-dns.rendered
}

resource "aws_iam_role_policy_attachment" "external-dns-attach" {
  role       = var.worker_iam_role_name
  policy_arn = aws_iam_policy.external-dns.arn

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "policy-assume-role" {
  template = file("${path.module}/files/policy-assume-role.tpl")
  vars = {
    RoleARN = var.worker_iam_role_arn
  }
}

data "template_file" "policy-cert-manager" {
  template = file("${path.module}/files/policy-cert-manager.tpl")
  vars = {
    role     = aws_iam_role.cert-manager-role.arn
    zone_ids = join(",", var.zone_ids)
  }
}

data "template_file" "policy-external-dns" {
  template = file("${path.module}/files/policy-external-dns.tpl")
  vars = {
    zone_ids = join(",", var.zone_ids)
  }
}
