variable "receiver_aws_account_number" {
  description = "AWS account number to which logs will be sent"
}

variable "receiver_aws_assume_role" {
  description = "AWS role to assume in receiver AWS account"
}

variable "receiver_aws_firehose_name" {
  description = "Target firehose name is receiver AWS account"
}

variable "firehose_log_sender_lambda_zip_file_path" {
  description = "AWS log sender Lambda zip file path"
}

variable "tags" {
  description = "AWS tags"
  type        = map(string)
}
