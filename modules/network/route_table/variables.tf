variable "vpc_id" {
  type = string
}

variable "route_table_names" {
  description = "List of route table names"
  type        = list(string)
}

variable "igw_id" {
  type    = string
  default = ""
}

variable "nat_gateway_id" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
