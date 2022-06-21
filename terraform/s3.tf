locals {
  # bucket_name = module.s3["website_logs"].bucket_name
  buckets = {
    website_logs = {
      bucket_name = "${var.website}-site-logs"
      acl         = "log-delivery-write"
    }
    website = {
      bucket_name = "${var.website}"
      acl         = "public-read"
      policy      = data.aws_iam_policy_document.website.json
      website = {
        index_document = "index.html"
        error_document = "index.html"
      }
      logging = {
        target_bucket = "${var.website}-site-logs"
        target_prefix = "${var.website}/"
      }
      with_files = true
      files_root = "../webapp"
    }
    www_redirect = {
      bucket_name = "www.${var.website}"
      acl         = "public-read"
      policy      = data.aws_iam_policy_document.www.json

      website = {
        redirect_all_requests_to = "http://${var.website}.s3-website-${var.aws_region}.amazonaws.com"
      }
    }
    lambda_bucket = {
      bucket_name = "${var.website}-lambda-bucket"
      acl         = "private"
      with_files  = true
      files_root  = "${path.root}/../lambda/zip"
    }
  }
}

module "s3" {
  source      = "./s3"
  for_each    = local.buckets
  bucket_name = each.value.bucket_name
  acl         = try(each.value.acl, "private")
  policy      = try(each.value.policy, "")
  logging     = try(each.value.logging, {})
  website     = try(each.value.website, {})
  files_root  = try(each.value.files_root, "")
  with_files  = try(each.value.with_files, false)
}