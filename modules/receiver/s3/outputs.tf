output "id" {
  value       = aws_s3_bucket.main.id
  description = "AWS S3 bucket id"
}

output "arn" {
  value       = aws_s3_bucket.main.arn
  description = "AWS S3 bucket ARN"
}
