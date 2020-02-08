locals {
  es_application_log_group_tags = {
    "Name" = "/aws/aes/domains/${var.domain_name}/application-logs"
  }
  search_slow_log_group_tags = {
    "Name" = "/aws/aes/domains/${var.domain_name}/search-slow-logs"
  }
  index_slow_log_group_tags = {
    "Name" = "/aws/aes/domains/${var.domain_name}/index-slow-logs"
  }
}

resource "aws_cloudwatch_log_group" "es_application_logs" {
  name = local.es_application_log_group_tags["Name"]
  tags = merge(local.es_application_log_group_tags, var.tags)
}

resource "aws_cloudwatch_log_group" "search_slow_logs" {
  name = local.search_slow_log_group_tags["Name"]
  tags = merge(local.search_slow_log_group_tags, var.tags)
}

resource "aws_cloudwatch_log_group" "index_slow_logs" {
  name = local.index_slow_log_group_tags["Name"]
  tags = merge(local.index_slow_log_group_tags, var.tags)
}
