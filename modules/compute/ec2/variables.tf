variable "instance_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Associate a public IP address with the EC2 instance"
}
