variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix to be used for all resources"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS service"
  type        = list(string)
}

variable "lb_target_group_arn" {
  description = "ARN of the target group to attach to the load balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_sg" {
  description = "ALB security group"
  type        = string
}

variable "task_cpu" {
  type    = number
  default = 256
}

variable "task_memory" {
  type    = number
  default = 512
}

variable "task_desired_count" {
  description = "Number of desired ECS tasks"
  type        = number
  default     = 1
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cf_log_group_name" {
  description = "CloudWatch log group name"
  type        = string
}

variable "efs_id" {
  description = "EFS file system ID"
  type        = string
}

variable "ecs_sg" {
  description = "Security Group ID for ECS tasks"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for storing the HTML file"
  type        = string
}
