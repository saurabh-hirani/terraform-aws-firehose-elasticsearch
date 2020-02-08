locals {
  log_group_tags = {
    "Name" = var.log_group_name != "" ? var.log_group_name : "${var.firehose_name}-firehose-log-group"
  }
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/kinesisfirehose/${var.firehose_name}"
  tags = merge(local.log_group_tags, var.tags)
}

resource "aws_cloudwatch_log_stream" "s3" {
  log_group_name = aws_cloudwatch_log_group.main.name
  name           = "S3Delivery"
}

resource "aws_cloudwatch_log_stream" "elasticsearch" {
  log_group_name = aws_cloudwatch_log_group.main.name
  name           = "ElasticSearchDelivery"
}
