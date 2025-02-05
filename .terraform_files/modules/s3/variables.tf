variable "common_tags" {
  description = "Tags for S3 bucket"
  type        = map(string)
}

variable "prefix" {
  description = "Prefix for bucket name"
  type        = string
}
