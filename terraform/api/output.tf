output "domain_name" {
    value = aws_api_gateway_deployment.deploy.invoke_url
}