variable "zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
}

variable "record_name" {
  description = "The name of the record."
  type        = string
}

variable "record_type" {
  description = "The record type."
  type        = string
  default     = "A"
}

variable "ttl" {
  description = "The TTL of the record."
  type        = number
  default     = 60
}

variable "failover_routing_policies" {
  description = "The failover routing policies for the record."
  type        = list(map(string))
}

variable "set_identifier" {
  description = "The identifier for the record set."
  type        = string
}

variable "health_check_id" {
  description = "The health check ID for the primary record."
  type        = string
  default     = null
}

variable "record_value" {
  description = "The value of the record."
  type        = list(string)
  default     = null
}
