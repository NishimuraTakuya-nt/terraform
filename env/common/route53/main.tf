locals {
  domain_name = "n-tech-plant.com"
  dev_ip      = "13.231.19.165" # fixme 仮の値
}

# ホストゾーン
resource "aws_route53_zone" "main" {
  name = local.domain_name
}

# レコード dev1
resource "aws_route53_record" "dev1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev1.n-tech-plant.com"
  type    = "A"
  ttl     = 300
  records = [local.dev_ip]
}