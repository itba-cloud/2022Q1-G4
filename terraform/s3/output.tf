output "bucket_name" {
    value = aws_s3_bucket.bucket.bucket
}

output "bucket_id" {
    value = aws_s3_bucket.bucket.id
}

output "bucket_objects" {
    value = aws_s3_object.file
}

output "bucket_domain_name" {
    value = aws_s3_bucket.bucket.website_endpoint
}