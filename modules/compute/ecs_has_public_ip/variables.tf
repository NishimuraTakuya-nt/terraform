variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "Family name of the task definition"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = string
}

variable "task_memory" {
  description = "Memory for the task in MiB"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
}

variable "container_memory" {
  description = "Memory for the container in MiB"
  type        = number
}

variable "container_memory_reservation" {
  description = "Memory reservation for the container in MiB"
  type        = number
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "operating_system_family" {
  description = "Operating system family for the task"
  type        = string
}

variable "cpu_architecture" {
  description = "CPU architecture for the task"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
}

variable "platform_version" {
  description = "Platform version for Fargate tasks"
  type        = string
}

variable "enable_execute_command" {
  description = "Enable execute command functionality"
  type        = bool
}

variable "health_check_grace_period_seconds" {
  description = "Health check grace period in seconds"
  type        = number
}

variable "deployment_maximum_percent" {
  description = "Maximum percent of tasks that can be running during a deployment"
  type        = number
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum percent of tasks that must remain healthy during a deployment"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign public IP to the task"
  type        = bool
}

variable "enable_deployment_circuit_breaker" {
  description = "Enable deployment circuit breaker"
  type        = bool
}

variable "enable_deployment_circuit_breaker_rollback" {
  description = "Enable rollback for deployment circuit breaker"
  type        = bool
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}