output "health_check_id" {
  value       = aws_route53_health_check.main.id
  description = "The ID of the health check."
}