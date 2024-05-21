# common/route53 remote state ファイルの読み込み
data "terraform_remote_state" "common_route53" {
  backend = "s3"
  config = {
    bucket = "wnt-terraform-state"
    key    = "env/common/route53/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# api_test remote state ファイルの読み込み
data "terraform_remote_state" "api_test" {
  backend = "s3"
  config = {
    bucket = "wnt-terraform-state"
    key    = "env/dev/api_test/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# レコード dev1
module "dev1_record" {
  source = "../../../modules/network/route53/dns_record"

  zone_id      = data.terraform_remote_state.common_route53.outputs.zone_id
  record_name  = "dev1.n-tech-plant.com"
  record_type  = "A"
  ttl          = 300
  record_value = [data.terraform_remote_state.api_test.outputs.public_ip]
}
