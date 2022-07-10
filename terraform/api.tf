locals {
  apis = {
    lambda_api = {
      name               = "lambda-api"
      description        = "Api for lambda"
      invoke_arn         = module.lambda["lambda"].invoke_arn
      api_path           = "{proxy+}"
      api_env_stage_name = "terraform-lambda-java-stage"
      policy             = data.aws_iam_policy_document.api_policy.json
    }
  }
}

module "api" {
  source   = "./api"
  for_each = local.apis

  name               = each.value.name
  description        = each.value.description
  invoke_arn         = each.value.invoke_arn
  api_path           = each.value.api_path
  api_env_stage_name = each.value.api_env_stage_name
  policy             = each.value.policy
}