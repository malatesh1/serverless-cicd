provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = { Service = "lambda.amazonaws.com" },
      Effect = "Allow",
    }]
  })
}

resource "aws_lambda_function" "lambda_func" {
  function_name = "my_serverless_lambda"
  runtime       = "nodejs18.x"         # or python3.11
  role          = aws_iam_role.lambda_role.arn
  handler       = "handler.handler"    # entry point
  filename      = "${path.module}/../lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda.zip")
}

