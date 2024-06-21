resource "aws_route53_record" "main" {
  zone_id = var.alias_zone_id
  name    = var.alias_record_name
  type    = var.alias_record_type

  dynamic "failover_routing_policy" {
    for_each = var.alias_failover_routing_policies
    content {
      type = failover_routing_policy.value.type
    }
  }

  set_identifier  = var.alias_set_identifier
  health_check_id = var.alias_health_check_id

  alias {
    name                   = var.alias.domain_name
    zone_id                = var.alias.zone_id
    evaluate_target_health = var.alias.evaluate_target_health
  }
}
