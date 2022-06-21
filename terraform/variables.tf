variable "aws_region" {
  default = "us-east-1"
}

variable "website" {
  default = "mi-pagina-de-cvs-con-terraform"
}

data "aws_iam_policy_document" "website" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.website}/*"
    ]
  }
}

data "aws_iam_policy_document" "www" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::www.${var.website}/*"
    ]
  }
}

data "archive_file" "lambda_hello_world" {
  type = "zip"

  source_dir  = "${path.module}/../lambda/files"
  output_path = "${path.module}/../lambda/zip/lambda.zip"
}

data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    # condition {
    #   test     = "StringNotEquals"
    #   variable = "aws:sourceVpce"

    #   values = [data.aws_vpc_endpoint_service.dynamodb.id]
    # }
  }
}

data "aws_iam_policy_document" "api_policy" {
  statement {
    effect    = "Allow"
    actions   = ["execute-api:Invoke"]
    resources = ["execute-api:/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    # condition {
    #   test     = "StringNotEquals"
    #   variable = "aws:sourceVpce"

    #   values = [data.aws_vpc_endpoint_service.dynamodb.id]
    # }
  }
}