provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "monitoring/route53_health_check"
      Env       = "dev"
    }
  }
}