resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = false
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = var.vpc_name
  }
}