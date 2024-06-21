variable "origin_s3_bucket_id" {
  description = "The ID of the S3 bucket to use as the origin."
  type        = string
}

variable "origin_s3_bucket_arn" {
  description = "The ARN of the S3 bucket to use as the origin."
  type        = string
}

variable "origin_s3_bucket_domain_name" {
  description = "The domain name of the S3 bucket to use as the origin."
  type        = string
}

variable "origin_id" {
  description = "The ID of the origin."
  type        = string
  default     = ""
}

variable "origin_path" {
  description = "The path to the origin content in the S3 bucket"
  type        = string
  default     = ""
}

variable "default_root_object" {
  description = "The default root object for the distribution."
  type        = string
  default     = "index.html"
}

variable "alias_domain_name" {
  type        = string
  description = "The alias domain name for the CloudFront distribution"
}

variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate to use for the CloudFront distribution"
}
