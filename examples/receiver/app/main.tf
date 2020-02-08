locals {
  xformation_lambda_name = "test-firehose-xformation-lambda"
  firehose_elasticsearch_vars = {
    index_name = "test-es-index"
  }
}

data "aws_caller_identity" "current" {}

module "s3" {
  source      = "../../../modules/receiver/s3"
  bucket_name = "test-firehose-es-backup"
  tags        = var.tags
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

module "elasticsearch" {
  source                 = "../../../modules/receiver/elasticsearch"
  domain_name            = "test-es"
  elasticsearch_version  = 7.1
  instance_type          = "i3.large.elasticsearch"
  dedicated_master_type  = "m4.large.elasticsearch"
  dedicated_master_count = 3
  instance_count         = 3
  tags                   = var.tags
  es_advanced_options    = { "rest.action.multi.allow_explicit_index" = "true" }
  es_whitelist_ips       = "${chomp(data.http.myip.body)}/32"
}

module "xformation_lambda" {
  source                     = "../../../modules/common/lambda"
  lambda_name                = local.xformation_lambda_name
  lambda_iam_role_name       = local.xformation_lambda_name
  lambda_iam_trust_document  = "${file("${path.module}/files/xformation_lambda_iam_trust_document.json")}"
  lambda_iam_policy_document = "${file("${path.module}/files/xformation_lambda_iam_policy.json")}"
  lambda_iam_policy_name     = "${local.xformation_lambda_name}-policy"
  lambda_zip_file_path       = var.xformation_lambda_zip_file_path
  lambda_s3_bucket           = "${data.aws_caller_identity.current.account_id}-${local.xformation_lambda_name}"
  lambda_handler             = "xformation_lambda.lambda_handler"
  lambda_runtime             = "python3.7"
  lambda_timeout             = 300
  lambda_memory_size         = 512
  lambda_description         = "test-firehose xformation lambda"
  tags                       = var.tags

  lambda_environment_variables = {
    "XFORMATION_FUNCS"        = "xformation_utils.convert_to_underscore,xformation_utils.convert_epoch_ms_to_iso8601"
    "EXTRACT_INDEX_DATE_FUNC" = "xformation_utils.extract_date_from_iso8601"
    "TIMESTAMP_KEY"           = "log_timestamp"
    "LOG_LEVEL"               = "INFO"
  }
}

data "aws_arn" "xformation_lambda" {
  arn = module.xformation_lambda.arn
}

module "firehose" {
  source                            = "../../../modules/receiver/firehose"
  firehose_name                     = "test-firehose"
  firehose_s3_bucket_arn            = module.s3.arn
  firehose_elasticsearch_domain_arn = module.elasticsearch.arn
  firehose_elasticsearch_vars       = local.firehose_elasticsearch_vars
  firehose_lambda_arn               = module.xformation_lambda.arn
  src_aws_account_number            = var.sender_aws_account_number
  tags                              = var.tags
}

data "aws_arn" "firehose" {
  arn = module.firehose.arn
}

module "cloudwatch_dashboard" {
  source                  = "../../../modules/receiver/cloudwatch"
  metrics_dashboard_name  = "test-es-firehose-metrics"
  insights_dashboard_name = "test-es-firehose-insights"
  dashboard_vars = {
    "es_domain_name"                = module.elasticsearch.domain_name
    "xformation_lambda_name"        = element(split(":", data.aws_arn.xformation_lambda.resource), 1)
    "firehose_delivery_stream_name" = element(split("/", data.aws_arn.firehose.resource), 1)

    // Using timestamp will trigger recreation of this resource on every plan - use static value of date if you want
    // to prevent that
    // Known issue - https://github.com/hashicorp/terraform/issues/22461
    "target_date" = formatdate("YYYY-MM-DD", timestamp())
  }
}
