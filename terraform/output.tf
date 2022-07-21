output "cloudfront_webpage_domain_name" {
  value = module.cloudfront["cloudfront_www"].domain_name
}

output "www_bucket_domain_name" {
  value = module.s3["www_redirect"].bucket_domain_name
}

output "api_url" {
  value = module.api["lambda_api"].invoke_url
}

output "cognito_endpoint" {
  value = module.cognito["main_pool"].endpoint
}

output "cognito_client_id" {
  value = module.cognito["main_pool"].client_id
}

output "cognito_domain" {
  value = module.cognito["main_pool"].domain
}

output "cognito_id" {
  value = module.cognito["main_pool"].id
}