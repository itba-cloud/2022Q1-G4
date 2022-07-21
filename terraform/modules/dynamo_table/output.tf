output "hash_key" {
  description = "Invoke URL for API Gateway stage."

  value = aws_dynamodb_table.this.hash_key
}

output "id" {
  description = "Invoke URL for API Gateway stage."

  value = aws_dynamodb_table.this.id
}

output "arn" {
  description = "Invoke URL for API Gateway stage."

  value = aws_dynamodb_table.this.arn
}