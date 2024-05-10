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

  vpc_id   = module.vpc.vpc_id
  igw_name = "n-plant-dev-igw"
}

# Nat Gateway
module "nat_gateway" {
  source = "../../../modules/network/nat_gateway"

  subnet_id        = module.public_subnet_1.subnet_id
  nat_gateway_name = "n-plant-dev-ngw"
}

# Route Table # todo ap-northeast-1c 側は、とりあえず作成しない
module "public_route_table" {
  source = "../../../modules/network/route_table"

  vpc_id           = module.vpc.vpc_id
  route_table_name = "n-plant-dev-public-1a-rt"
  igw_id           = module.igw.igw_id
  subnet_id        = module.public_subnet_1.subnet_id
}

module "private_route_table" {
  source = "../../../modules/network/route_table"

  vpc_id           = module.vpc.vpc_id
  route_table_name = "n-plant-dev-private-1a-rt"
  nat_gateway_id   = module.nat_gateway.nat_gateway_id
  subnet_id        = module.private_subnet_1.subnet_id
}