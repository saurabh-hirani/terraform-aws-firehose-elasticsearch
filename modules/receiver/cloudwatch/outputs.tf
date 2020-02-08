output "metrics_arn" {
  description = "AWS Cloudwatch metrics dashboard arn"
  value       = aws_cloudwatch_dashboard.metrics.dashboard_arn
}

output "insights_arn" {
  description = "AWS Cloudwatch insights dashboard arn"
  value       = aws_cloudwatch_dashboard.insights.dashboard_arn
}
