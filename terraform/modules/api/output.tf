output "invoke_url" {
  value = aws_api_gateway_deployment.this.invoke_url
}

output "resource_id" {
  value = aws_api_gateway_resource.this.id
}