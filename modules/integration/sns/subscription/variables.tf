variable "sns_subscription_topic_arn" {
  type        = string
  description = "The ARN of the SNS topic to subscribe to."
}

variable "protocol" {
  type        = string
  description = "The protocol used for the subscription (e.g., 'email', 'sms', 'https')."
}

variable "endpoint" {
  type        = string
  description = "The endpoint to send the subscription notifications to (e.g., an email address or a URL)."
}