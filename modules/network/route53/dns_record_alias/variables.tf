variable "alias_zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
}

variable "alias_record_name" {
  description = "The name of the record."
  type        = string
}

variable "alias_record_type" {
  description = "The record type."
  type        = string
  default     = "A"
}

variable "alias_failover_routing_policies" {
  description = "The failover routing policies for the record."
  type        = list(map(string))
}

variable "alias_set_identifier" {
  description = "The identifier for the record set."
  type        = string
}

variable "alias_health_check_id" {
  description = "The health check ID for the primary record."
  type        = string
  default     = null
}

variable "alias" {
  description = "The alias configuration for the record."
  type = object({
    domain_name            = string
    zone_id                = string
    evaluate_target_health = optional(bool)
  })
  default = null
}
