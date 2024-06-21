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

# dev1_health_check remote state ファイルの読み込み
data "terraform_remote_state" "dev1_api_test_health_check" {
  backend = "s3"
  config = {
    bucket = "wnt-terraform-state"
    key    = "env/dev/monitoring/route53_health_check/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

module "dev1_assets_s3" {
  source = "../../../modules/storage/s3/bucket"

  bucket_name = "dev1-n-tech-plant-assets"
  versioning  = true

  folders = [
    {
      path = "static_website/sorry_page"
    }
  ]
}

# ACM SSL証明書の作成
module "acm_certificate" {
  source = "../../../modules/network/acm"

  domain_name     = "*.n-tech-plant.com"
  route53_zone_id = data.terraform_remote_state.common_route53.outputs.zone_id

  region = "us-east-1"
}

module "cloudfront" {
  source = "../../../modules/network/cloudfront"

  origin_id                    = "dev1_assets_s3_sorry_page"
  origin_s3_bucket_id          = module.dev1_assets_s3.bucket_id
  origin_s3_bucket_arn         = module.dev1_assets_s3.bucket_arn
  origin_s3_bucket_domain_name = module.dev1_assets_s3.bucket_domain_name
  origin_path                  = "/static_website/sorry_page"
  default_root_object          = "index.html"
  alias_domain_name            = "dev1.n-tech-plant.com"
  acm_certificate_arn          = module.acm_certificate.acm_certificate_arn
}

# レコード dev1 api test primary
module "dev1_api_test_record_primary" {
  source = "../../../modules/network/route53/dns_record"

  zone_id     = data.terraform_remote_state.common_route53.outputs.zone_id
  record_name = "dev1.n-tech-plant.com"
  record_type = "A"
  ttl         = 60
  failover_routing_policies = [
    {
      type = "PRIMARY"
    }
  ]
  set_identifier  = "primary"
  health_check_id = data.terraform_remote_state.dev1_api_test_health_check.outputs.dev1_api_test_health_check_id
  record_value    = [data.terraform_remote_state.api_test.outputs.public_ip]
}

# レコード dev1 api test secondary
module "dev1_api_test_record_secondary" {
  source = "../../../modules/network/route53/dns_record_alias"

  alias_zone_id     = data.terraform_remote_state.common_route53.outputs.zone_id
  alias_record_name = "dev1.n-tech-plant.com"
  alias_record_type = "A"
  alias_failover_routing_policies = [
    {
      type = "SECONDARY"
    }
  ]
  alias_set_identifier = "secondary"
  alias = {
    domain_name            = module.cloudfront.domain_name
    zone_id                = module.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}
