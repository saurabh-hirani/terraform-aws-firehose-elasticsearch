
data "aws_caller_identity" "current" {}

locals {
  default_dashboard_vars = {
    "aws_region"         = "us-east-1"
    "aws_account_number" = data.aws_caller_identity.current.account_id
    "target_date"        = formatdate("YYYY-MM-DD", timestamp())
  }
  dashboard_vars = merge(local.default_dashboard_vars, var.dashboard_vars)
}

data "template_file" "cloudwatch_metrics_dashboard_tpl" {
  template = file("${path.module}/templates/cloudwatch-metrics-dashboard.json.tpl")

  vars = {
    es_domain_name                = local.dashboard_vars["es_domain_name"]
    aws_region                    = local.dashboard_vars["aws_region"]
    aws_account_number            = local.dashboard_vars["aws_account_number"]
    xformation_lambda_name        = local.dashboard_vars["xformation_lambda_name"]
    firehose_delivery_stream_name = local.dashboard_vars["firehose_delivery_stream_name"]
  }
}

resource "aws_cloudwatch_dashboard" "metrics" {
  dashboard_name = var.metrics_dashboard_name
  dashboard_body = data.template_file.cloudwatch_metrics_dashboard_tpl.rendered
}

data "template_file" "cloudwatch_insights_dashboard_tpl" {
  template = file("${path.module}/templates/cloudwatch-insights-dashboard.json.tpl")

  vars = {
    aws_region             = local.dashboard_vars["aws_region"]
    xformation_lambda_name = local.dashboard_vars["xformation_lambda_name"]
    target_date            = local.dashboard_vars["target_date"]
  }
}

resource "aws_cloudwatch_dashboard" "insights" {
  dashboard_name = var.insights_dashboard_name
  dashboard_body = data.template_file.cloudwatch_insights_dashboard_tpl.rendered
}
