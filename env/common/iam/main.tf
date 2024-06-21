###############################################################################
# dev-admin:
###############################################################################
resource "aws_iam_user" "dev-admin" {
  name                 = "dev-admin"
  path                 = "/"
  permissions_boundary = null
  tags                 = {}
  tags_all             = {}
}

resource "aws_iam_user_policy_attachment" "dev-admin_access_attachment" {
  user       = aws_iam_user.dev-admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

###############################################################################
# dev-user-1:
###############################################################################
resource "aws_iam_user" "dev-user-1" {
  name                 = "dev-user-1"
  path                 = "/"
  permissions_boundary = null
  tags                 = {}
  tags_all             = {}
}

resource "aws_iam_group" "dev-power-users" {
  name = "dev-power-users"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "dev-power-user-policy-attachment" {
  group      = aws_iam_group.dev-power-users.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user_group_membership" "dev-power-user-membership" {
  user = aws_iam_user.dev-user-1.name

  groups = [
    aws_iam_group.dev-power-users.name,
  ]
}

###############################################################################
# ci:
###############################################################################
resource "aws_iam_user" "ci" {
  name                 = "ci"
  path                 = "/"
  permissions_boundary = null
  tags                 = {}
  tags_all             = {}
}

resource "aws_iam_policy" "ci" {
  description = null
  name        = "ci"
  name_prefix = null
  path        = "/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "ec2:*",
            "rds:*",
            "s3:*",
            "dynamodb:*",
            "lambda:*",
            "cloudwatch:*",
            "logs:*",
            "iam:*",
            "ssm:GetParameter",
            "route53:GetHostedZone",
            "route53:ListHostedZones",
            "route53:CreateHostedZone",
            "route53:DeleteHostedZone",
            "route53:UpdateHostedZoneComment",
            "route53:ListTagsForResource",
            "route53:ChangeResourceRecordSets",
            "route53:ListResourceRecordSets",
            "route53:GetChange",
            "route53:GetHealthCheck",
            "route53:CreateHealthCheck",
            "route53:UpdateHealthCheck",
            "route53:DeleteHealthCheck",
            "route53:ListHealthChecks",
            "route53:ChangeTagsForResource",
            "sns:*",
            "acm:RequestCertificate",
            "acm:DescribeCertificate",
            "acm:ListCertificates",
            "acm:DeleteCertificate",
            "acm:ListTagsForCertificate",
            "cloudfront:CreateDistribution",
            "cloudfront:GetDistribution",
            "cloudfront:UpdateDistribution",
            "cloudfront:DeleteDistribution",
            "cloudfront:TagResource",
            "cloudfront:CreateOriginAccessControl",
            "cloudfront:GetOriginAccessControl",
            "cloudfront:UpdateOriginAccessControl",
            "cloudfront:DeleteOriginAccessControl",
            "cloudfront:ListOriginAccessControls",
            "cloudfront:ListTagsForResource",
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
      Version = "2012-10-17"
    }
  )
  tags     = {}
  tags_all = {}
}

resource "aws_iam_role" "ci" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "sts:AssumeRole",
            "sts:TagSession",
          ]
          Effect = "Allow"
          Principal = {
            AWS = aws_iam_user.ci.arn
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  description           = null
  force_detach_policies = false
  managed_policy_arns = [
    aws_iam_policy.ci.arn,
  ]
  max_session_duration = 3600
  name                 = "ci"
  name_prefix          = null
  path                 = "/"
  permissions_boundary = null
  tags                 = {}
  tags_all             = {}
}