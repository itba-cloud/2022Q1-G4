

resource "aws_api_gateway_rest_api" "api" {
  name          = var.name
  description   = var.description
  policy        = var.policy
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": "execute-api:Invoke",
#             "Resource": [
#                 "execute-api:/*"
#             ]
#         }
#     ]
# }
# EOF
}
resource "aws_api_gateway_resource" "resource" {
  rest_api_id               = "${aws_api_gateway_rest_api.api.id}"
  parent_id                 = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part                 = var.api_path
}

resource "aws_api_gateway_method" "method" {
  rest_api_id               = "${aws_api_gateway_rest_api.api.id}"
  resource_id               = "${aws_api_gateway_resource.resource.id}"
  http_method               = "ANY"
  authorization             = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id               = "${aws_api_gateway_rest_api.api.id}"
  resource_id               = "${aws_api_gateway_resource.resource.id}"
  http_method               = "${aws_api_gateway_method.method.http_method}"
  credentials               = var.credentials
#   credentials               = "arn:aws:iam::969205814093:role/LabRole"

  integration_http_method   = "POST"
  type                      = "AWS_PROXY"
#   uri                       = "${aws_lambda_function.lambda_managram_api.invoke_arn}"
  uri                       = var.invoke_arn
}

# Unfortunately the proxy resource cannot match an empty path at the root of the API.
# To handle that, a similar configuration must be applied to the root resource that is built in to the REST API object:
resource "aws_api_gateway_method" "method_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_root" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_method.method_root.resource_id}"
  http_method = "${aws_api_gateway_method.method_root.http_method}"
#   credentials             = "arn:aws:iam::969205814093:role/LabRole"
  credentials               = "arn:aws:iam::969205814093:role/LabRole"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn
}

resource "aws_api_gateway_deployment" "deploy" {
  depends_on = [
    aws_api_gateway_integration.integration, 
    aws_api_gateway_method.method_root,
    aws_api_gateway_method.method
  ]
  rest_api_id               = "${aws_api_gateway_rest_api.api.id}"
  stage_name                = var.api_env_stage_name
}