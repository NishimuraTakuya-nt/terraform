module "dev1_health_check" {
  source = "../../../../modules/network/route53/health_check"

  fqdn              = "dev1.n-tech-plant.com"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = "dev1-r53-hc-n-tech-plant"
  }
}

module "sns_topic" {
  source     = "../../../../modules/integration/sns/topic"
  topic_name = "dev1-r53-hc-alarm-topic"
}

# パラメータストアからメールアドレスを取得
data "aws_ssm_parameter" "ssm_mail_address_key_name" {
  name            = "mail-address"
  with_decryption = true
}

module "sns_subscription" {
  source                     = "../../../../modules/integration/sns/subscription"
  sns_subscription_topic_arn = module.sns_topic.sns_topic_arn
  protocol                   = "email"
  endpoint                   = data.aws_ssm_parameter.ssm_mail_address_key_name.value
}

module "cloudwatch_alarm" {
  source              = "../../../../modules/monitoring/cloudwatch/alarm"
  alarm_name          = "dev1-r53-hc-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "1"
  alarm_description   = "Alarm when health check status is unhealthy"
  sns_topic_arn       = module.sns_topic.sns_topic_arn

  dimensions = {
    HealthCheckId = module.dev1_health_check.health_check_id
  }
}