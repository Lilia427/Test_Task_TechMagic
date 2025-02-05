variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix to be used for all resources"
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

variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}

variable "health_check_url" {
  description = "Health check path for ALB"
  type        = string
  default     = "/" 
}

variable "ec2_instance_id" {
  description = "ID of the EC2 instance to attach to the ALB"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security group ID of EC2 instance"
  type        = string
}

