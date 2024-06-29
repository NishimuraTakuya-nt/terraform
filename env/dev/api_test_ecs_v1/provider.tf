provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "create ecs v1"
      Env       = "dev"
    }
  }
}