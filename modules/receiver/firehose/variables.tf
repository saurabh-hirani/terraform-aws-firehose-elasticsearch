variable "firehose_name" {
  type        = string
  description = "Firehose name"
}

variable "firehose_s3_bucket_arn" {
  type        = string
  description = "Firehose S3 bucket destination ARN"
}

variable "firehose_elasticsearch_domain_arn" {
  type        = string
  description = "Firehose Elasticsearch domain destination ARN"
}

variable "firehose_lambda_arn" {
  type        = string
  description = "Firehose transformation lambda ARN"
}

variable "firehose_role_name" {
  type        = string
  description = "AWS Kinesis Firehose role name"
  default     = ""
}

variable "src_aws_account_number" {
  description = "Sender AWS account number"
}

variable "firehose_policy_name" {
  type        = string
  description = "AWS Kinesis Firehose policy name"
  default     = ""
}

variable "log_group_name" {
  type        = string
  description = "Cloudwatch log group name"
  default     = ""
}

variable "log_stream_name" {
  type        = string
  description = "Cloudwatch log stream name"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}

variable "firehose_elasticsearch_vars" {
  type        = map(string)
  description = "Firehose Elasticsearch variables"
  default     = {}
}

variable "firehose_s3_vars" {
  type        = map(string)
  description = "Firehose S3 variables"
  default     = {}
}
