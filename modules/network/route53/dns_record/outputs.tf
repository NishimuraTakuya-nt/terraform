output "record_name" {
  value       = aws_route53_record.record.name
  description = "The name of the record."
}

output "record_fqdn" {
  value       = aws_route53_record.record.fqdn
  description = "The FQDN of the record."
}