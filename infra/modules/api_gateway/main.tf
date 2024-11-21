resource "aws_api_gateway_rest_api" "zipper_api" {
  name        = var.api_gateway_name
  description = "API for Zipper project"
}

resource "aws_api_gateway_resource" "zipper_resource" {
  rest_api_id = aws_api_gateway_rest_api.zipper_api.id
  parent_id   = aws_api_gateway_rest_api.zipper_api.root_resource_id
  path_part   = "zipperresource"
}

resource "aws_api_gateway_method" "zipper_method" {
  rest_api_id   = aws_api_gateway_rest_api.zipper_api.id
  resource_id   = aws_api_gateway_resource.zipper_resource.id
  http_method   = "GET"
  authorization = "NONE"
}
