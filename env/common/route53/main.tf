locals {
  domain_name = "n-tech-plant.com"
}

# ホストゾーン
resource "aws_route53_zone" "main" {
  name = local.domain_name
}
