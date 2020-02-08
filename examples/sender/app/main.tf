locals {
  firehose_log_sender_lambda_name = "test-firehose-log-sender-lambda"
}

data "aws_caller_identity" "current" {}

data "template_file" "firehose_iam_policy_tpl" {
  template = file("${path.module}/templates/firehose_log_sender_lambda_iam_policy.json.tpl")

  vars = {
    receiver_aws_assume_role = var.receiver_aws_assume_role
  }
}

module "firehose_log_sender_lambda" {
  source                     = "../../../modules/common/lambda"
  lambda_name                = local.firehose_log_sender_lambda_name
  lambda_iam_role_name       = local.firehose_log_sender_lambda_name
  lambda_iam_trust_document  = "${file("${path.module}/files/firehose_log_sender_lambda_iam_trust_document.json")}"
  lambda_iam_policy_document = data.template_file.firehose_iam_policy_tpl.rendered
  lambda_iam_policy_name     = "${local.firehose_log_sender_lambda_name}-policy"
  lambda_zip_file_path       = var.firehose_log_sender_lambda_zip_file_path
  lambda_s3_bucket           = "${data.aws_caller_identity.current.account_id}-${local.firehose_log_sender_lambda_name}"
  lambda_handler             = "firehose_log_sender.lambda_handler"
  lambda_runtime             = "python3.7"
  lambda_timeout             = 300
  lambda_memory_size         = 512
  lambda_description         = "test-firehose-log-sender lambda"
  tags                       = var.tags

  lambda_environment_variables = {
    "AWS_ASSUME_ROLE_ARN"      = var.receiver_aws_assume_role
    "AWS_FIREHOSE_STREAM_NAME" = var.receiver_aws_firehose_name
    "LOG_LEVEL"                = "INFO"
  }
}
