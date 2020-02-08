variable "lambda_s3_bucket" {
  description = "S3 Bucket where lambda code is uploaded"
}

variable "lambda_name" {
  description = "Lambda function name"
}

variable "lambda_iam_trust_document" {
  description = "Lambda IAM trust document for role"
}

variable "lambda_iam_role_name" {
  description = "Lambda IAM role name"
}

variable "lambda_iam_policy_document" {
  description = "Lambda IAM policy document"
}

variable "lambda_iam_policy_name" {
  description = "Lambda IAM policy name"
}

variable "lambda_zip_file_path" {
  description = "Lambda function code zip file path"
}

variable "lambda_handler" {
  description = "Lambda function handler"
}

variable "lambda_runtime" {
  description = "Lambda function runtime"
}

variable "lambda_memory_size" {
  description = "Lambda function memory size"
}

variable "lambda_timeout" {
  description = "Lambda function timeout"
}

variable "lambda_description" {
  description = "Lambda function description"
}

variable "lambda_environment_variables" {
  type        = map(string)
  description = "Lambda function environment variables"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
