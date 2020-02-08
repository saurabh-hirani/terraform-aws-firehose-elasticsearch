locals {
  domain_tags = {
    "Name" = var.domain_name
  }
}

data "aws_caller_identity" "current" {}

data "template_file" "es_access_policy_tpl" {
  template = file("${path.module}/templates/es-access-policy.json.tpl")
  vars = {
    aws_region         = var.aws_region
    domain_name        = var.domain_name
    es_whitelist_ips   = "${jsonencode(split(",", var.es_whitelist_ips))}"
    aws_account_number = data.aws_caller_identity.current.account_id
  }
}

resource "aws_elasticsearch_domain" "main" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = "true"
    dedicated_master_type    = var.dedicated_master_type
    dedicated_master_count   = var.dedicated_master_count
  }

  advanced_options = var.es_advanced_options

  access_policies = data.template_file.es_access_policy_tpl.rendered

  encrypt_at_rest {
    enabled = "true"
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  log_publishing_options {
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_application_logs.arn
    enabled                  = true
  }

  log_publishing_options {
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.search_slow_logs.arn
    enabled                  = true
  }

  log_publishing_options {
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.index_slow_logs.arn
    enabled                  = true
  }


  tags = merge(local.domain_tags, var.tags)
}
