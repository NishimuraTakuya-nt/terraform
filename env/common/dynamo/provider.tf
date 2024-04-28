provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "aws initialize"
      Env       = "common"
    }
  }
}