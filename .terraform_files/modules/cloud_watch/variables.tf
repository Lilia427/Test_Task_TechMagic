variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix to be applied to all resources"
  type        = string
}

variable "cf_log_group_name" {
  description = "CloudWatch log group name"
  type        = string
}
