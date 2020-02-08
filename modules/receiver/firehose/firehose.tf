locals {
  firehose_tags = {
    "Name" = var.firehose_name
  }

  default_firehose_elasticsearch_vars = {
    index_name            = "ul"
    index_rotation_period = "OneDay"
    buffering_size        = "5"
    buffering_interval    = "300"
    s3_backup_mode        = "AllDocuments"
  }
  firehose_elasticsearch_vars = "${merge(local.default_firehose_elasticsearch_vars, var.firehose_elasticsearch_vars)}"

  default_firehose_s3_vars = {
    buffer_size        = 5
    buffer_interval    = 300
    compression_format = "UNCOMPRESSED"
  }
  firehose_s3_vars = "${merge(local.default_firehose_s3_vars, var.firehose_s3_vars)}"
}

resource "aws_kinesis_firehose_delivery_stream" "main" {
  name        = var.firehose_name
  destination = "elasticsearch"

  s3_configuration {
    role_arn           = aws_iam_role.firehose.arn
    bucket_arn         = var.firehose_s3_bucket_arn
    buffer_size        = local.firehose_s3_vars["buffer_size"]
    buffer_interval    = local.firehose_s3_vars["buffer_interval"]
    compression_format = local.firehose_s3_vars["compression_format"]

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.main.name
      log_stream_name = aws_cloudwatch_log_stream.s3.name
    }
  }

  elasticsearch_configuration {
    domain_arn            = var.firehose_elasticsearch_domain_arn
    role_arn              = aws_iam_role.firehose.arn
    index_name            = local.firehose_elasticsearch_vars["index_name"]
    index_rotation_period = local.firehose_elasticsearch_vars["index_rotation_period"]
    buffering_size        = local.firehose_elasticsearch_vars["buffering_size"]
    buffering_interval    = local.firehose_elasticsearch_vars["buffering_interval"]
    s3_backup_mode        = local.firehose_elasticsearch_vars["s3_backup_mode"]

    processing_configuration {
      enabled = "true"
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${var.firehose_lambda_arn}:$LATEST"
        }
      }
    }

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.main.name
      log_stream_name = aws_cloudwatch_log_stream.elasticsearch.name
    }
  }

  tags = merge(local.firehose_tags, var.tags)
}
