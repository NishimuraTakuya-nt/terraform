output "record_name" {
  value       = aws_route53_record.main.name
  description = "The name of the record."
}

output "record_fqdn" {
  value       = aws_route53_record.main.fqdn
  description = "The FQDN of the record."
}