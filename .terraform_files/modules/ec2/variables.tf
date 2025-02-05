variable "ami" {
  description = "Amazon Machine Image ID for EC2 instance"
  type        = string
}

variable "subnet_a_id" {
  description = "ID of the subnet for the EC2 instance"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource naming"
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

variable "common_tags" {
  description = "Common tags for resources"
  type        = map(string)
}
