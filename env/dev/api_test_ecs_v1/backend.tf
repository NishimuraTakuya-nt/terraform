terraform {
  backend "s3" {
    bucket         = "wnt-terraform-state"
    key            = "env/dev/api_test_ecs_v1/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}