resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = var.sns_subscription_topic_arn
  protocol  = var.protocol
  endpoint  = var.endpoint
}