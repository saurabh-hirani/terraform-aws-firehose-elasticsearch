output "s3_arn" {
  value = module.s3.arn
}

output "elasticsearch_arn" {
  value = module.elasticsearch.arn
}

output "elasticsearch_endpoint" {
  value = module.elasticsearch.endpoint
}

output "kibana_endpoint" {
  value = module.elasticsearch.kibana_endpoint
}

output "firehose_arn" {
  value = module.firehose.arn
}

output "kinesis_agent_role_arn" {
  value = module.firehose.kinesis_agent_role_arn
}

output "metrics_dashboard_arn" {
  value = module.cloudwatch_dashboard.metrics_arn
}

output "insights_dashboard_arn" {
  value = module.cloudwatch_dashboard.insights_arn
}

output "xformation_lambda_arn" {
  value = module.xformation_lambda.arn
}
