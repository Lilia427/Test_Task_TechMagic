resource "aws_s3_bucket" "html_bucket" {
  bucket = "${var.prefix}-html-bucket"

  tags = var.common_tags
}

resource "aws_s3_bucket_ownership_controls" "html_bucket_ownership" {
  bucket = aws_s3_bucket.html_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_object" "html_file" {
  bucket = aws_s3_bucket.html_bucket.id
  key    = "index.html"
  source = "${path.root}/index.html" 
  content_type = "text/html"
}
