variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix to be applied to all resources"
  type        = string
}

variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_a_cidr_block" {
  description = "CIDR block for Subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_b_cidr_block" {
  description = "CIDR block for Subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_c_cidr_block" {
  description = "CIDR block for Subnet C"
  type        = string
  default     = "10.0.3.0/24"
}
