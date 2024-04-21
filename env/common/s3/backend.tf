terraform {
  backend "s3" {
    bucket = "wnt-terraform-state"
    key            = "env/common/s3/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}