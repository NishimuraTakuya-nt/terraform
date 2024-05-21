terraform {
  backend "s3" {
    bucket         = "wnt-terraform-state"
    key            = "env/dev/monitoring/route53_health_check/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}