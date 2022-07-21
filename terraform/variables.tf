variable "aws_region" {
  default = "us-east-1"
}

variable "website" {
  default = "serverless-cv-builder"
}

data "archive_file" "lambda" {
  type = "zip"

  source_dir  = "${path.module}/../lambda/files"
  output_path = "${path.module}/../lambda/zip/lambda.zip"
}

variable "role" {
  type    = string
  default = "arn:aws:iam::969205814093:role/LabRole"
}

