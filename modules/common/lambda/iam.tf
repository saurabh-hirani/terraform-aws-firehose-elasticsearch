locals {
  lambda_iam_role = {
    "Name" = var.lambda_iam_role_name
  }
}

resource "aws_iam_role" "lambda" {
  name               = var.lambda_iam_role_name
  assume_role_policy = var.lambda_iam_trust_document
  tags               = merge(local.lambda_iam_role, var.tags)
}

resource "aws_iam_policy" "lambda" {
  name   = var.lambda_iam_policy_name
  policy = var.lambda_iam_policy_document
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}

