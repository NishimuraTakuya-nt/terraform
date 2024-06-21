resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = var.ttl

  dynamic "failover_routing_policy" {
    for_each = var.failover_routing_policies
    content {
      type = failover_routing_policy.value.type
    }
  }

  set_identifier  = var.set_identifier
  health_check_id = var.health_check_id

  records = var.record_value
}
