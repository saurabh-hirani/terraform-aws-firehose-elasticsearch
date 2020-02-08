data "template_file" "es_application_logs_policy_tpl" {
  template = file("${path.module}/templates/es-logs-policy.json.tpl")

  vars = {
    log_group = aws_cloudwatch_log_group.es_application_logs.arn
  }
}

resource "aws_cloudwatch_log_resource_policy" "es_application_logs" {
  policy_document = data.template_file.es_application_logs_policy_tpl.rendered
  policy_name     = "${var.domain_name}-es-application-logs"
}

data "template_file" "search_slow_logs_policy_tpl" {
  template = file("${path.module}/templates/es-logs-policy.json.tpl")

  vars = {
    log_group = aws_cloudwatch_log_group.search_slow_logs.arn
  }
}

resource "aws_cloudwatch_log_resource_policy" "search_slow_logs" {
  policy_document = data.template_file.search_slow_logs_policy_tpl.rendered
  policy_name     = "${var.domain_name}-search-slow-logs"
}

data "template_file" "index_slow_logs_policy_tpl" {
  template = file("${path.module}/templates/es-logs-policy.json.tpl")

  vars = {
    log_group = aws_cloudwatch_log_group.index_slow_logs.arn
  }
}

resource "aws_cloudwatch_log_resource_policy" "index_slow_logs" {
  policy_document = data.template_file.index_slow_logs_policy_tpl.rendered
  policy_name     = "${var.domain_name}-index-slow-logs"
}
