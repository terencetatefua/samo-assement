resource "aws_dynamodb_table" "inventory" {
  name           = "InventoryTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ItemId"
  attribute {
    name = "ItemId"
    type = "S"
  }
}

output "table_arn" {
  value = aws_dynamodb_table.inventory.arn
}
