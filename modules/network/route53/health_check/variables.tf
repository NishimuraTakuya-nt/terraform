variable "fqdn" {
  type        = string
  description = "The fully qualified domain name of the endpoint to be health checked."
}

variable "port" {
  type        = number
  description = "The port of the endpoint to be health checked."
  default     = 80
}

variable "type" {
  type        = string
  description = "The type of health check to be performed (e.g., 'HTTP', 'HTTPS', 'TCP')."
  default     = "HTTP"
}

variable "resource_path" {
  type        = string
  description = "The path of the endpoint to be health checked."
  default     = "/"
}

variable "failure_threshold" {
  type        = string
  description = "The number of consecutive health checks that an endpoint must pass or fail before Route 53 changes the current status of the endpoint."
  default     = "3"
}

variable "request_interval" {
  type        = string
  description = "The number of seconds between the time that Route 53 gets a response from your endpoint and the time that it sends the next health check request."
  default     = "30"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the health check."
  default     = {}
}
