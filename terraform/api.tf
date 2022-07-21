data "aws_iam_policy_document" "api" {
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

locals {
  apis = {
    lambda_api = {
      name                    = "lambda-api"
      description             = "Api for Lambda"
      invoke_arn              = module.lambda["main_lambda"].invoke_arn
      api_path                = "{proxy+}"
      api_env_stage_name      = "prod"
      policy                  = data.aws_iam_policy_document.api.json
      http_method             = "ANY"
      authorization           = "NONE"
      integration_http_method = "POST"
      integration_type        = "AWS_PROXY"
      credentials             = var.role
    }
  }
}



module "api" {
  source   = "./modules/api"
  for_each = local.apis

  name                    = each.value.name
  description             = each.value.description
  invoke_arn              = each.value.invoke_arn
  api_path                = each.value.api_path
  api_env_stage_name      = each.value.api_env_stage_name
  policy                  = each.value.policy
  authorization           = each.value.authorization
  http_method             = each.value.http_method
  integration_http_method = each.value.integration_http_method
  integration_type        = each.value.integration_type
  credentials             = each.value.credentials
}