locals {
  lambda_tags = {
    "Name" = var.lambda_name
  }
  lambda_environment_map = var.lambda_environment_variables == null ? [] : [var.lambda_environment_variables]
}

// This assumes that the code has already been packaged in a zip file
resource "aws_s3_bucket_object" "lambda" {
  bucket = aws_s3_bucket.lambda.id
  key    = "${var.lambda_name}.zip"
  source = var.lambda_zip_file_path
  etag   = filemd5(var.lambda_zip_file_path)
}

resource "aws_lambda_function" "lambda" {
  s3_bucket        = aws_s3_bucket.lambda.id
  s3_key           = "${var.lambda_name}.zip"
  function_name    = var.lambda_name
  description      = var.lambda_description
  role             = aws_iam_role.lambda.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  memory_size      = var.lambda_memory_size
  timeout          = var.lambda_timeout
  source_code_hash = filebase64sha256(var.lambda_zip_file_path)
  depends_on       = [aws_s3_bucket_object.lambda]


  dynamic "environment" {
    for_each = local.lambda_environment_map
    content {
      variables = environment.value
    }
  }

  tags = merge(local.lambda_tags, var.tags)
}
