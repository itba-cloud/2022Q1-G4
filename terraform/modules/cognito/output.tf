output "arn" {
  value = aws_cognito_user_pool.this.arn
}

output "id" {
  value = aws_cognito_user_pool.this.id
}

output "endpoint" {
  value = aws_cognito_user_pool.this.endpoint
}

output "domain" {
  value = aws_cognito_user_pool.this.domain
}

output "client_id" {
  value = aws_cognito_user_pool_client.this.id
}