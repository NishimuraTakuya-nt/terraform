resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "OAC for ${var.origin_s3_bucket_id}"
  description                       = "OAC for ${var.origin_s3_bucket_id}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name              = var.origin_s3_bucket_domain_name
    origin_id                = var.origin_id
    origin_path              = var.origin_path
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = [var.alias_domain_name]

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  # 費用がかかるのでwafは関連付けない
  #   web_acl_id = aws_wafv2_web_acl.main.arn
}

resource "aws_s3_bucket_policy" "this" {
  bucket = var.origin_s3_bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontAccessOriginControl"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${var.origin_s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.main.arn
          }
        }
      }
    ]
  })
}

# waf acl のリージョンは us-east-1 に作成する必要がある
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

# 費用がかかるのでwafは関連付けない
# resource "aws_wafv2_web_acl" "main" {
#   name        = "core-protection-waf-acl"
#   description = "Core protection WAF ACL"
#   scope       = "CLOUDFRONT"
#   provider    = aws.us-east-1
#
#   default_action {
#     allow {}
#   }
#
#   rule {
#     name     = "AWSManagedRulesCommonRuleSet"
#     priority = 1
#
#     override_action {
#       none {}
#     }
#
#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesCommonRuleSet"
#         vendor_name = "AWS"
#       }
#     }
#
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWSManagedRulesCommonRuleSetMetric"
#       sampled_requests_enabled   = true
#     }
#   }
#
#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "CoreProtectionMetric"
#     sampled_requests_enabled   = true
#   }
# }
