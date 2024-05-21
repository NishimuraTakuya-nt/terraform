variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone to contain this record."
}

variable "record_name" {
  type        = string
  description = "The name of the record."
}

variable "record_type" {
  type        = string
  description = "The record type (e.g., 'A', 'CNAME', 'MX')."
  default     = "A"
}

variable "ttl" {
  type        = number
  description = "The TTL (Time To Live) of the record."
  default     = 300
}

variable "record_value" {
  type        = list(string)
  description = "A list of values for the record."
}