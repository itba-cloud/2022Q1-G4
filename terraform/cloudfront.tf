locals {
  cloudfront_distrs = {
    cloudfront_www = {
      domain_name         = module.s3["website"].bucket_domain_name
      origin_id           = "custom-s3-origin"
      comment             = "cloudfront build"
      default_root_object = "index.html"
      default_cache_behavior = {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods  = ["GET", "HEAD"]

        forwarded_values = {
          query_string = false

          cookies = {
            forward = "none"
          }
        }
        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
      }
      ordered_cache_behavior = {
        cache_1 = {
          path_pattern    = "/content/immutable/*"
          allowed_methods = ["GET", "HEAD", "OPTIONS"]
          cached_methods  = ["GET", "HEAD", "OPTIONS"]

          forwarded_values = {
            query_string = false
            headers      = ["Origin"]

            cookies = {
              forward = "none"
            }
          }

          min_ttl                = 0
          default_ttl            = 86400
          max_ttl                = 31536000
          compress               = true
          viewer_protocol_policy = "allow-all"
        }
        cache_2 = {
          path_pattern    = "/content/*"
          allowed_methods = ["GET", "HEAD", "OPTIONS"]
          cached_methods  = ["GET", "HEAD"]

          forwarded_values = {
            query_string = false
            headers      = ["Origin"]
            cookies = {
              forward = "none"
            }
          }

          min_ttl                = 0
          default_ttl            = 3600
          max_ttl                = 86400
          compress               = true
          viewer_protocol_policy = "allow-all"
        }
      }
    }
  }
}

module "cloudfront" {
  source   = "./modules/cloudfront"
  for_each = local.cloudfront_distrs

  domain_name            = each.value.domain_name
  origin_id              = each.value.origin_id
  comment                = each.value.comment
  default_root_object    = each.value.default_root_object
  default_cache_behavior = each.value.default_cache_behavior
  ordered_cache_behavior = each.value.ordered_cache_behavior
}