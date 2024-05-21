output "zone_id" {
  value       = aws_route53_zone.main.zone_id
  description = "The ID of the hosted zone to contain this record."
}
