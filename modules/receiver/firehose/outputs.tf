output "arn" {
  value       = aws_kinesis_firehose_delivery_stream.main.arn
  description = "AWS Kinesis stream ARN"
}

output "kinesis_agent_role_arn" {
  value       = aws_iam_role.kinesis_agent.arn
  description = "AWS Kinesis agent role ARN"
}

output "log_group_arn" {
  value       = aws_cloudwatch_log_group.main.arn
  description = "AWS Cloudwatch log group ARN"
}
