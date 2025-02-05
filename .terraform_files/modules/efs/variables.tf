variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix for EFS resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_a_id" {
  description = "Subnet A ID"
  type        = string
}

variable "subnet_b_id" {
  description = "Subnet B ID"
  type        = string
}

variable "subnet_c_id" {
  description = "Subnet C ID"
  type        = string
}

variable "ecs_sg" {
  description = "ECS security group ID"
  type        = string
}
