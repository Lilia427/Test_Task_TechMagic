output "region" {
  value = var.region
}

output "terraform_workspace" {
  value = terraform.workspace
}

output "project_name" {
  value = var.project_name
}

# VPC and Subnets
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_a_id" {
  value = module.vpc.subnet_a_id
}

output "subnet_b_id" {
  value = module.vpc.subnet_b_id
}

output "subnet_c_id" {
  value = module.vpc.subnet_c_id
}

# Security Groups
output "ecs_sg" {
  value = module.ecs_fargate.ecs_sg
}

output "alb_sg" {
  value = module.load_balancer.alb_sg
}

# CloudWatch
output "cf_log_group_name" {
  value = module.cloud_watch.cf_log_group_name
}

# EFS
output "efs_id" {
  value = module.efs.efs_id
}

output "efs_mount_target_ids" {
  value = module.efs.mount_target_ids
}

# ECS Fargate
output "ecs_service_name" {
  value = module.ecs_fargate.ecs_service_name
}

output "ecs_task_definition_arn" {
  value = module.ecs_fargate.task_definition_arn
}

# ALB
output "alb_arn" {
  value = module.load_balancer.alb_arn
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "alb_target_group_arn" {
  value = module.load_balancer.lb_target_group_arn
}

# Tags
output "common_tags" {
  value = var.common_tags
}
