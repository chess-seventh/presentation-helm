resource "aws_security_group" "demo_sg" {
  name   = "demo-sg"
  vpc_id = module.demo_vpc.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "demo-sg"
    Environment = var.env
    Terraform   = true
  }
}
