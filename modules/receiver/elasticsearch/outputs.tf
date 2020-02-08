output "arn" {
  description = "AWS Elasticsearch ARN"
  value       = aws_elasticsearch_domain.main.arn
}

output "domain_id" {
  description = "AWS Elasticsearch Domain ID"
  value       = aws_elasticsearch_domain.main.id
}

output "domain_name" {
  description = "AWS Elasticsearch Domain name"
  value       = aws_elasticsearch_domain.main.domain_name
}

output "endpoint" {
  description = "AWS Elasticsearch endpoint"
  value       = aws_elasticsearch_domain.main.endpoint
}

output "kibana_endpoint" {
  description = "AWS Elasticsearch kibana_endpoint"
  value       = aws_elasticsearch_domain.main.kibana_endpoint
}
