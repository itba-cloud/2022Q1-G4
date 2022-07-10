output "cloudfront_webpage_domain_name" {
  value = module.cloudfront["cloudfront_www"].domain_name
}

output "www_bucket_domain_name" {
  value = module.s3["www_redirect"].bucket_domain_name
}

output "api_url" {
  value = module.api["lambda_api"].domain_name
}
