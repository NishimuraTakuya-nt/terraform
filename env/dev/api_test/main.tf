# VPC state ファイルの読み込み
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "wnt-terraform-state"
    key    = "env/dev/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# security group
module "ec2_security_group_public" {
  source = "../../../modules/network/security_group"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  security_group_name = "dev-sg-public-01"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2_security_group_private" {
  source = "../../../modules/network/security_group"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  security_group_name = "dev-sg-private-01"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}