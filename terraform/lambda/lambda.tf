resource "aws_lambda_function" "lambda" {
  function_name = var.function_name

  s3_bucket     = var.bucket_id
  s3_key        = var.bucket_object_key

  memory_size   = var.memory_size
  runtime       = var.runtime
  handler       = var.handler
  timeout       = var.timeout
  role          = var.role

  source_code_hash = filebase64sha256(var.file_path)

  # vpc_config {
  #   security_group_ids  = var.security_group_ids
  #   subnet_ids          = var.subnet_ids
  # }

  dynamic "vpc_config" {
    for_each = var.vpc_config ? [1] : []

    content{
      security_group_ids  = var.security_group_ids
      subnet_ids          = var.subnet_ids
    }
  }

  dynamic "environment" {
    for_each = length(var.env_vars) > 0 ? [1] : []
    content {
      variables = var.env_vars
    }
  }
  # environment {
  #   variables = {
  #     url:      var.db_address,
  #     dbname:   var.db_name,
  #     username: var.db_username,
  #     password: var.db_password,
  #     encrypt_key: "ManagramTelegramBot2021"
  #   }
  # }
}

# resource "aws_cloudwatch_log_group" "lambda_managram_api" {
#   name              = "/aws/lambda/${aws_lambda_function.lambda_managram_api.function_name}"
#   retention_in_days = 30
# } todo