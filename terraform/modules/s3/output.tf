output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_objects" {
  value = merge(aws_s3_object.template_files, aws_s3_object.files)
}

output "bucket_domain_name" {
  value = aws_s3_bucket.this.website_endpoint
}

output "arn" {
  value = aws_s3_bucket.this.arn
}