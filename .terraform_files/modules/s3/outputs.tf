output "bucket_name" {
  description = "S3 Bucket name"
  value       = aws_s3_bucket.html_bucket.id
}
