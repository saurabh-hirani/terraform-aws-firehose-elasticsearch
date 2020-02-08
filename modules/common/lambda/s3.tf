locals {
  s3_bucket_tags = {
    "Name" = var.lambda_s3_bucket
  }
}

resource "aws_s3_bucket" "lambda" {
  bucket = replace(var.lambda_s3_bucket, "_", "-")
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = merge(local.s3_bucket_tags, var.tags)
}

