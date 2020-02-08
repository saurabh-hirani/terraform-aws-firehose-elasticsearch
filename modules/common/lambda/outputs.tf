output "arn" {
  description = "Lambda function arn"
  value       = aws_lambda_function.lambda.arn
}

output "s3_id" {
  description = "Lambda S3 bucket name"
  value       = aws_s3_bucket.lambda.id
}

output "role_arn" {
  description = "Lambda role arn"
  value       = aws_iam_role.lambda.arn
}
