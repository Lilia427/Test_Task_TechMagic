terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket  = "tm-devops-trainee-techmagic-tfstate"
    key     = "resources.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

locals {
  prefix      = "${terraform.workspace}-${var.project_name}"
  environment = terraform.workspace
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source              = "./modules/vpc"
  common_tags         = local.common_tags
  prefix              = local.prefix
  vpc_cidr_block      = var.vpc_cidr_block
  subnet_a_cidr_block = var.subnet_a_cidr_block
  subnet_b_cidr_block = var.subnet_b_cidr_block
  subnet_c_cidr_block = var.subnet_c_cidr_block
  region              = var.region
}

module "cloud_watch" {
  source            = "./modules/cloud_watch"
  common_tags       = local.common_tags
  prefix            = local.prefix
  cf_log_group_name = "${local.prefix}-ecs-task-logs"
}

module "efs" {
  source      = "./modules/efs"
  common_tags = local.common_tags
  prefix      = local.prefix
  vpc_id      = module.vpc.vpc_id
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id
  subnet_c_id = module.vpc.subnet_c_id
  ecs_sg      = module.ecs_fargate.ecs_sg
}


module "ecs_fargate" {
  source              = "./modules/ecs_fargate"
  common_tags         = local.common_tags
  prefix              = local.prefix
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.vpc.subnet_a_id, module.vpc.subnet_b_id, module.vpc.subnet_c_id]
  task_cpu            = var.task_cpu
  task_memory         = var.task_memory
  task_desired_count  = var.task_desired_count
  cf_log_group_name   = module.cloud_watch.cf_log_group_name
  efs_id              = module.efs.efs_id
  alb_sg              = module.load_balancer.alb_sg
  lb_target_group_arn = module.load_balancer.lb_target_group_arn
  region              = var.region
  ecs_sg              = module.load_balancer.alb_sg
  s3_bucket_name      = module.s3.bucket_name
}

module "load_balancer" {
  source           = "./modules/load_balancer"
  common_tags      = local.common_tags
  prefix           = local.prefix
  vpc_id           = module.vpc.vpc_id
  subnet_a_id      = module.vpc.subnet_a_id
  subnet_b_id      = module.vpc.subnet_b_id
  subnet_c_id      = module.vpc.subnet_c_id
  health_check_url = var.health_check_url
  ec2_instance_id  = module.ec2.ec2_instance_id
  ec2_sg_id        = module.ec2.ec2_sg_id     
}


module "s3" {
  source      = "./modules/s3"
  common_tags = local.common_tags
  prefix      = local.prefix
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami
  subnet_a_id   = var.subnet_a_id
  prefix        = var.prefix
  efs_id        = var.efs_id
  vpc_id        = var.vpc_id
  ec2_sg        = var.ec2_sg
  common_tags   = var.common_tags
}




resource "local_file" "html_file" {
  content  = <<EOT
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMagic Test</title>
</head>
<body>
    <h1>Hello, TechMagic!</h1>
</body>
</html>
EOT
  filename = "${path.module}/index.html"
}
