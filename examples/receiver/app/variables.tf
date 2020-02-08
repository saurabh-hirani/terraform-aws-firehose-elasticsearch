variable tags {
  description = "AWS tags"
  type        = map(string)
}

variable sender_aws_account_number {
  description = "AWS account number from which logs will be sent"
}

variable xformation_lambda_zip_file_path {
  description = "AWS Transformation Lambda zip file path"
}
