resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  # acl    = var.acl
  policy = var.policy

  # dynamic "website" {
  #   for_each = length(var.website) > 0 ? [1] : []
  #   content {
  #     index_document           = try(var.website.index_document, null)
  #     error_document           = try(var.website.error_document, null)
  #     redirect_all_requests_to = try(var.website.redirect_all_requests_to, null)
  #   }
  # }

  # dynamic "logging" {
  #   for_each = length(var.logging) > 0 ? (length(var.logging.target_bucket) > 0 ? [1] : []) : []
  #   content {
  #     target_bucket = try(var.logging.target_bucket, null)
  #     target_prefix = try(var.logging.target_prefix, null)
  #   }
  # }
}

resource "aws_s3_bucket_website_configuration" "example" {
  count = length(var.website) > 0 ? 1 : 0

  bucket = aws_s3_bucket.this.bucket
  dynamic "index_document" {
    for_each = length(lookup(var.website, "index_document", "")) > 0 ? { a = 1 } : {}
    content {
      suffix = var.website.index_document
    }
  }

  dynamic "error_document" {
    for_each = length(lookup(var.website, "error_document", "")) > 0 ? { a = 1 } : {}
    content {
      key = var.website.error_document
    }
  }
  dynamic "redirect_all_requests_to" {
    for_each = length(lookup(var.website, "redirect_all_requests_to", "")) > 0 ? { a = 1 } : {}

    content {
      host_name = var.website.redirect_all_requests_to
    }
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.bucket
  acl    = var.acl
}

resource "aws_s3_bucket_logging" "this" {
  count  = length(var.logging) > 0 ? length(var.logging.target_bucket) > 0 ? 1 : 0 : 0
  bucket = aws_s3_bucket.this.bucket

  target_bucket = var.logging.target_bucket
  target_prefix = var.logging.target_prefix

}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

locals {
  mime_types = jsondecode(file("${path.module}/mime.json"))
}

resource "aws_s3_object" "files" {
  for_each = length(var.files) > 0 ? fileset(var.files.path, var.files.pattern) : fileset("/", "")

  bucket = aws_s3_bucket.this.id

  key    = each.key
  source = "${var.files.path}/${each.key}"
  acl    = try(var.acl, "private")

  etag         = filemd5("${var.files.path}/${each.key}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), "text/plain")
}

resource "aws_s3_object" "template_files" {
  for_each = length(var.template_files) > 0 ? var.template_files : {}

  bucket = aws_s3_bucket.this.id

  key     = each.key
  content = each.value.rendered
  acl     = try(var.acl, "private")

  # etag         = filemd5("${var.files_root}/${each.key}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), "text/plain")
}