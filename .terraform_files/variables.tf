variable "project_name" {
  description = "Name of the project"
  default     = "tm-devops-trainee"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "subnet_a_cidr_block" {
  description = "CIDR block for Subnet A"
  default     = "10.0.1.0/24"
  type        = string
}

variable "cf_log_group_name" {
  description = "CloudWatch log group name"
  type        = string
}


variable "subnet_b_cidr_block" {
  description = "CIDR block for Subnet B"
  default     = "10.0.2.0/24"
  type        = string
}

variable "subnet_c_cidr_block" {
  description = "CIDR block for Subnet C"
  default     = "10.0.3.0/24"
  type        = string
}

variable "app_port" {
  description = "Application port"
  default     = 80
  type        = number
}

variable "task_cpu" {
  description = "CPU for ECS task"
  default     = 256
  type        = number
}

variable "task_memory" {
  description = "Memory for ECS task"
  default     = 512
  type        = number
}

variable "task_desired_count" {
  description = "Number of desired ECS tasks"
  default     = 1
  type        = number
}

variable "health_check_url" {
  description = "Health check URL for ALB"
  default     = "/"
  type        = string
}

# Added variables for EFS
variable "efs_throughput_mode" {
  description = "Throughput mode for EFS"
  default     = "bursting"
  type        = string
}

variable "efs_performance_mode" {
  description = "Performance mode for EFS"
  default     = "generalPurpose"
  type        = string
}

# Added variables for ALB security group
variable "alb_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access ALB"
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "alb_ingress_ports" {
  description = "Ports allowed for ALB ingress"
  default     = [80]
  type        = list(number)
}

# Added variables for ECS Fargate
variable "ecs_execution_role_arn" {
  description = "IAM Role ARN for ECS task execution"
  default     = ""
  type        = string
}

variable "ecs_task_role_arn" {
  description = "IAM Role ARN for ECS task"
  default     = ""
  type        = string
}

# Added variable for Target Group Health Check
variable "target_group_health_check" {
  description = "Settings for target group health check"
  default = {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  type = object({
    path                = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })
}

# Added variables for tags
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "efs_id" {
  description = "EFS ID for mounting"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the resources"
  type        = string
}

variable "ec2_sg" {
  description = "Security group ID for EC2 instance"
  type        = string
}
 
 variable "subnet_id" {
  description = "ID of the subnet for the EC2 instance"
  type        = string
}

variable "ami" {
  description = "Amazon Machine Image ID for EC2 instance"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., development, production)"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "subnet_a_id" {
  description = "ID of the primary subnet for the EC2 instance"
  type        = string
}
variable "subnet_b_id" {
  description = "ID of subnet B"
  type        = string
}

variable "subnet_c_id" {
  description = "ID of subnet C"
  type        = string
}
