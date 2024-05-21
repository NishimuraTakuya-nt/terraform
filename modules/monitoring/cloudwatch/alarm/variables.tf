variable "alarm_name" {
  type        = string
  description = "The name of the CloudWatch alarm."
}

variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified statistic and threshold (e.g., 'GreaterThanOrEqualToThreshold', 'LessThanThreshold')."
}

variable "evaluation_periods" {
  type        = number
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "metric_name" {
  type        = string
  description = "The name of the metric to monitor (e.g., 'CPUUtilization', 'HealthCheckStatus')."
}

variable "namespace" {
  type        = string
  description = "The namespace for the metric (e.g., 'AWS/EC2', 'AWS/Route53')."
}

variable "period" {
  type        = number
  description = "The period in seconds over which the specified statistic is applied."
}

variable "statistic" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric (e.g., 'Average', 'Maximum', 'Minimum')."
}

variable "threshold" {
  type        = number
  description = "The value against which the specified statistic is compared."
}

variable "alarm_description" {
  type        = string
  description = "The description for the alarm."
}

variable "sns_topic_arn" {
  type        = string
  description = "The ARN of the SNS topic to send alarm notifications to."
}

variable "dimensions" {
  type        = map(string)
  description = "The dimensions for the metric associated with the alarm."
}