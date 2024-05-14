# VPC remote state ファイルの読み込み
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
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
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

# IAM Role for EC2
resource "aws_iam_role" "ssm" {
  name = "ssm"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm.name
}

resource "aws_iam_role_policy" "ssm_inline_policy" {
  name = "ssm-inline-policy"
  role = aws_iam_role.ssm.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:StartSession",
          "ssm:TerminateSession"
        ]
        Resource = [
          "arn:aws:ec2:*:*:instance/*",
          "arn:aws:ssm:*:*:managed-instance/*",
          "arn:aws:ssm:*:*:document/SSM-SessionManagerRunShell",
          "arn:aws:ssm:*:*:session/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm-instance-profile"
  role = aws_iam_role.ssm.name
}


# パラメータストアから EC2 キーペアを取得
data "aws_ssm_parameter" "ssm_key_name" {
  name            = "/dev/public-ec2-key-pairs"
  with_decryption = true
}

## User Data session-manager-plugin, Nginx のインストール
locals {
  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
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
  key_pair_key_name           = data.aws_ssm_parameter.ssm_key_name.value
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name
  user_data                   = local.user_data
}

module "ec2_private" {
  source = "../../../modules/compute/ec2"

  instance_name          = "private-ec2-test-01"
  instance_type          = "t2.micro"
  ami_id                 = "ami-0ab3794db9457b60a"
  subnet_id              = data.terraform_remote_state.vpc.outputs.private_subnet_id_1
  vpc_security_group_ids = [module.ec2_security_group_private.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name
}