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

  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
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

  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
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

# EC2
module "ec2_public" {
  source = "../../../modules/compute/ec2"

  instance_name               = "public-ec2-test-01"
  instance_type               = "t2.micro"
  ami_id                      = "ami-0ab3794db9457b60a"
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_id_1
  vpc_security_group_ids      = [module.ec2_security_group_public.security_group_id]
  associate_public_ip_address = true
}

module "ec2_private" {
  source = "../../../modules/compute/ec2"

  instance_name          = "private-ec2-test-01"
  instance_type          = "t2.micro"
  ami_id                 = "ami-0ab3794db9457b60a"
  subnet_id              = data.terraform_remote_state.vpc.outputs.private_subnet_id_1
  vpc_security_group_ids = [module.ec2_security_group_private.security_group_id]
}