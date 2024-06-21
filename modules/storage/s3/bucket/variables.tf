variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the S3 bucket."
  type        = bool
  default     = false
}

variable "folders" {
  description = "A list of folders to create in the S3 bucket."
  type = list(object({
    path = string
  }))
  default = []
}
