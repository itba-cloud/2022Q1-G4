resource "aws_s3_bucket" "bucket" {
  bucket    = var.bucket_name
  acl       = var.acl
  policy    = var.policy

  dynamic "website" {
    for_each = length(var.website) > 0 ? [1] : []
    content {
      index_document            = try(var.website.index_document,null)
      error_document            = try(var.website.error_document,null)
      redirect_all_requests_to  = try(var.website.redirect_all_requests_to,null)
    }
  }

  dynamic "logging" {
    for_each = length(var.logging) > 0 ? [1] : []
    content {
      target_bucket = try(var.logging.target_bucket,null)
      target_prefix = try(var.logging.target_prefix,null)
    }
  }
}

locals {
  mime_types = jsondecode(file("${path.module}/mime.json"))
}

resource "aws_s3_object" "file" {
  for_each = var.with_files? fileset(var.files_root, "**") : []

  bucket = aws_s3_bucket.bucket.id

  key    = each.key
  source = "${var.files_root}/${each.key}"
  acl    = try(var.acl,"private")

  etag  = filemd5("${var.files_root}/${each.key}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), "text/plain")
}