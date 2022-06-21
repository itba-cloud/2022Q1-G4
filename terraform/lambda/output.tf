# # Output value definitions

# output "lambda_bucket_name" {
#   description = "Name of the S3 bucket used to store function code."

#   value = aws_s3_bucket.lambda_bucket.id
# }

# output "function_name" {
#   description = "Name of the Lambda function."

#   value = aws_lambda_function.lambda_managram_api.function_name
# }

output "invoke_arn" {
  description = "Invoke URL for API Gateway stage."

  value = aws_lambda_function.lambda.invoke_arn
}


