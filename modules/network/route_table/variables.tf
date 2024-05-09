variable "vpc_id" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "igw_id" {
  type = string
  default = ""
}

variable "nat_gateway_id" {
  type = string
  default = ""
}

variable "subnet_id" {
  type        = string
  description = "subnet ID"
}
