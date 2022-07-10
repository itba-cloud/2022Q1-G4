locals {
  cloudfront_distrs = {
    cloudfront_www = {
      # domain_name = replace(module.s3["www_redirect"].bucket_domain_name,".s3",".s3.${var.aws_region}" )
      domain_name         = module.s3["www_redirect"].bucket_domain_name
      origin_id           = "custom-s3-origin"
      comment             = "default cloufront build"
      default_root_object = "index.html"
    }
  }
}

module "cloudfront" {
  source   = "./cloudfront"
  for_each = local.cloudfront_distrs

  domain_name         = each.value.domain_name
  origin_id           = each.value.origin_id
  comment             = each.value.comment
  default_root_object = each.value.default_root_object

}