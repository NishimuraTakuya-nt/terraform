# パブリックIPを付与したECSタスク

# common/ecr remote state ファイルの読み込み
data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = "wnt-terraform-state"
    key    = "env/common/ecr/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# VPC remote state ファイルの読み込み
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "wnt-terraform-state"
    key    = "env/dev/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


module "ecs_has_public_ip" {
  source = "../../../modules/compute/ecs_has_public_ip"

  cluster_name                 = "n-tech-go-echo-api-cluster"
  task_family                  = "n-tech-go-echo-api-task-family"
  task_cpu                     = "256"
  task_memory                  = "512"
  container_name               = "n-tech-go-echo-api-container"
  container_image              = "${data.terraform_remote_state.ecr.outputs.repository_url}:latest"
  container_cpu                = 256
  container_memory             = 512
  container_memory_reservation = 512
  container_port               = 8080
  aws_region                   = "ap-northeast-1"

  operating_system_family = "LINUX"
  cpu_architecture        = "X86_64"

  service_name                       = "n-tech-go-echo-api-service"
  desired_count                      = 1
  platform_version                   = "LATEST"
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  subnet_ids       = [data.terraform_remote_state.vpc.outputs.public_subnet_id_1]
  assign_public_ip = true

  enable_deployment_circuit_breaker          = true
  enable_deployment_circuit_breaker_rollback = true

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}
