variable "static_web_site_bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "index_document" {
  description = "The name of the index document."
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "The name of the error document."
  type        = string
  default     = "error.html"
}

variable "source_dir" {
  description = "The directory containing the files to upload."
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the S3 bucket."
  type        = bool
  default     = true
}

variable "acl" {
  description = "The canned ACL to apply to the S3 bucket."
  type        = string
  default     = "public-read"
}