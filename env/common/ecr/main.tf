###############################################################################
# n-tech-go-echo:
###############################################################################
module "n-tech-go-echo" {
  source = "../../../modules/storage/ecr"

  repository_name = "n-tech-go-echo"
  scan_on_push    = false
  encryption_type = "KMS"
  #   kms_key           = aws_kms_key.ecr_key.arn
  image_tag_mutability = "IMMUTABLE"

  create_repository_policy = true
  repository_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPushPull"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })

  create_lifecycle_policy = true
  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# kms_key引数を指定しないことで、コンソールから作成した場合と同様に、AWSマネージド型キーが使用される。
# resource "aws_kms_key" "ecr_key" {
#   description             = "KMS key for ECR"
#   deletion_window_in_days = 7
# }
