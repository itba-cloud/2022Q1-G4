locals {
  endpoints = {
    dynamo_endpoint = {
      vpc_id          = module.vpc["vpc"].vpc_id
      service_name    = "com.amazonaws.us-east-1.dynamodb"
      policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      route_table_ids = [module.vpc["vpc"].private_route_table_id, module.vpc["vpc"].public_route_table_id]
    }
  }
}

module "vpc_endpoint" {
  for_each = local.endpoints
  source   = "./vpc_endpoint"

  vpc_id          = each.value.vpc_id
  service_name    = each.value.service_name
  policy          = each.value.policy
  route_table_ids = each.value.route_table_ids
}