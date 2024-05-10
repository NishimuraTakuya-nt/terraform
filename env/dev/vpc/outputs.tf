output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id_1" {
  value = module.public_subnet_1.subnet_id
}

output "public_subnet_id_2" {
  value = module.public_subnet_2.subnet_id
}

output "private_subnet_id_1" {
  value = module.private_subnet_1.subnet_id
}

output "private_subnet_id_2" {
  value = module.private_subnet_2.subnet_id
}
