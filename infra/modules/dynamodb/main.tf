resource "aws_dynamodb_table" "zipper_dynamodb" {
  name         = var.dynamodb_table
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }
}
