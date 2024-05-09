# VPC
module "vpc" {
  source = "../../../modules/network/vpc"

  vpc_cidr_block = "192.168.0.0/21"
  vpc_name       = "n-plant-dev-vpc"
}

# Subnet
module "public_subnet_1" {
  source = "../../../modules/network/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "192.168.0.0/23"
  availability_zone = "ap-northeast-1a"
  subnet_name       = "n-plant-dev-public-1a"
}

module "public_subnet_2" {
  source = "../../../modules/network/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "192.168.2.0/23"
  availability_zone = "ap-northeast-1c"
  subnet_name       = "n-plant-dev-public-1c"
}

module "private_subnet_1" {
  source = "../../../modules/network/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "192.168.4.0/23"
  availability_zone = "ap-northeast-1a"
  subnet_name       = "n-plant-dev-private-1a"
}

module "private_subnet_2" {
  source = "../../../modules/network/subnet"

  vpc_id            = module.vpc.vpc_id
  cidr_block        = "192.168.6.0/23"
  availability_zone = "ap-northeast-1c"
  subnet_name       = "n-plant-dev-private-1c"
}

# IGW
module "igw" {
  source = "../../../modules/network/internet_gateway"

  vpc_id = module.vpc.vpc_id
  igw_name = "n-plant-dev-igw"
}

# Nat Gateway
module "nat_gateway" {
  source = "../../../modules/network/nat_gateway"

  subnet_id   = module.public_subnet_1.subnet_id
  nat_gateway_name = "n-plant-dev-ngw"
}