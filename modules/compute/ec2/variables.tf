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

variable "key_pair_key_name" {
  type        = string
  default     = null
  description = "The name of the key pair to use for the EC2 instance"
}

variable "iam_instance_profile" {
  type        = string
  default     = null
  description = "The IAM instance profile to associate with the EC2 instance"
}

variable "user_data" {
  type        = string
  default     = null
  description = "The user data to provide when launching the EC2 instance for public subnet instances"
}
