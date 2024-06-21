variable "domain_name" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "route53_zone_id" {
  type        = string
  description = "The Route 53 zone ID where the certificate validation record will be added"
}

variable "region" {
  type        = string
  description = "The region to create the ACM certificate in"
}
