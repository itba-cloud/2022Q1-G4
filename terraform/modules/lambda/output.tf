output "invoke_arn" {
  description = "Invoke URL for lambda."

  value = aws_lambda_function.this.invoke_arn
}

output "id" {
  description = "id for lambda."

  value = aws_lambda_function.this.id
}

output "arn" {
  description = "arn for lambda."

  value = aws_lambda_function.this.arn
}

output "handler" {
  description = "handler for lambda."

  value = aws_lambda_function.this.handler
}


