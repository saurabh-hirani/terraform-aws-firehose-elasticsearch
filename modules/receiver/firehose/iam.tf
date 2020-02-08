locals {
  firehose_iam_role = {
    "Name" = var.firehose_role_name != "" ? var.firehose_role_name : "${var.firehose_name}-firehose"
  }
  kinesis_agent_iam_role = {
    "Name" = var.firehose_role_name != "" ? var.firehose_role_name : "${var.firehose_name}-kinesis_agent"
  }
}

data "template_file" "firehose_iam_policy_tpl" {
  template = file("${path.module}/templates/firehose-policy.json.tpl")

  vars = {
    firehose_s3_bucket_arn                      = var.firehose_s3_bucket_arn
    firehose_elasticsearch_domain_arn           = var.firehose_elasticsearch_domain_arn
    firehose_lambda_arn                         = var.firehose_lambda_arn
    aws_cloudwatch_log_stream_elasticsearch_arn = aws_cloudwatch_log_stream.elasticsearch.arn
    aws_cloudwatch_log_stream_s3_arn            = aws_cloudwatch_log_stream.s3.arn
  }
}

data "local_file" "firehose_assume_role_policy" {
  filename = "${path.module}/files/firehose-assume-role-policy.json"
}

resource "aws_iam_role" "firehose" {
  name               = local.firehose_iam_role["Name"]
  assume_role_policy = data.local_file.firehose_assume_role_policy.content
  tags               = merge(local.firehose_iam_role, var.tags)
}

resource "aws_iam_role_policy" "firehose_policy" {
  name   = "${aws_iam_role.firehose.name}-policy"
  role   = aws_iam_role.firehose.id
  policy = data.template_file.firehose_iam_policy_tpl.rendered
}

data "template_file" "kinesis_agent_iam_policy_tpl" {
  template = file("${path.module}/templates/kinesis_agent-policy.json.tpl")

  vars = {
    firehose_arn = aws_kinesis_firehose_delivery_stream.main.arn
  }
}

data "template_file" "kinesis_agent_assume_role_policy_tpl" {
  template = file("${path.module}/templates/kinesis_agent-assume-role-policy.json.tpl")

  vars = {
    src_aws_account_number = var.src_aws_account_number
  }
}

resource "aws_iam_role" "kinesis_agent" {
  name               = local.kinesis_agent_iam_role["Name"]
  assume_role_policy = data.template_file.kinesis_agent_assume_role_policy_tpl.rendered
  tags               = merge(local.kinesis_agent_iam_role, var.tags)
}

resource "aws_iam_role_policy" "kinesis_agent_policy" {
  name   = "${aws_iam_role.kinesis_agent.name}-policy"
  role   = aws_iam_role.kinesis_agent.id
  policy = data.template_file.kinesis_agent_iam_policy_tpl.rendered
}
