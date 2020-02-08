locals {
  bucket_tags = {
    "Name" = var.bucket_name
  }
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  lifecycle_rule {
    enabled = true
    expiration {
      days = var.expiration_days
    }
  }
  tags = merge(local.bucket_tags, var.tags)
}
