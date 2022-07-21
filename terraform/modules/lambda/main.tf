resource "aws_lambda_function" "this" {
  function_name = var.function_name

  # s3_bucket = var.bucket_id
  # s3_key    = var.bucket_object_key
  filename = var.file_path

  memory_size = var.memory_size
  runtime     = var.runtime
  handler     = var.handler
  timeout     = var.timeout
  role        = var.role

  source_code_hash = filebase64sha256(var.file_path)

  dynamic "vpc_config" {
    for_each = var.vpc_config ? [1] : []

    content {
      security_group_ids = var.security_group_ids
      subnet_ids         = var.subnet_ids
    }
  }

  dynamic "environment" {
    for_each = length(var.env_vars) > 0 ? [1] : []
    content {
      variables = var.env_vars
    }
  }
}