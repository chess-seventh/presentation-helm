data "aws_availability_zones" "available" {}

data "template_file" "pre_user_data" {
  template = file("./pre_userdata.sh.tpl")
}

## ES DEV
#
data "aws_caller_identity" "current" {}

