###############################################################################
# dev-admin:
###############################################################################
resource "aws_iam_user" "dev-admin" {
  name                 = "dev-admin"
  path                 = "/"
  permissions_boundary = null
  tags = {}
  tags_all = {}
}

resource "aws_iam_user_policy_attachment" "dev-admin_access_attachment" {
  user       = aws_iam_user.dev-admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

###############################################################################
# ci:
###############################################################################
resource "aws_iam_user" "ci" {
  name                 = "ci"
  path                 = "/"
  permissions_boundary = null
  tags = {}
  tags_all = {}
}

resource "aws_iam_policy" "ci" {
  description = null
  name        = "ci"
  name_prefix = null
  path        = "/"
  policy      = jsonencode(
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
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "iam:*",
          ]
          Effect   = "Allow"
          Resource = [
            "arn:aws:iam::*:user/ci",
            "arn:aws:iam::*:user/dev-*",
          ]
        },
      ]
      Version = "2012-10-17"
    }
  )
  tags = {}
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
  managed_policy_arns   = [
    aws_iam_policy.ci.arn,
  ]
  max_session_duration = 3600
  name                 = "ci"
  name_prefix          = null
  path                 = "/"
  permissions_boundary = null
  tags = {}
  tags_all = {}
}