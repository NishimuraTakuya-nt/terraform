resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_pair_key_name
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data

  tags = {
    Name = var.instance_name
  }
}