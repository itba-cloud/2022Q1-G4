locals {
  tables = {
    user_data = {
      name = "user_data"
      attributes = {
        userID = {
          name = "userID"
          type = "N"
        }
      }
      hash_key = "userID"
    }
  }
}

module "dynamo" {
  source = "./modules/dynamo_table"

  for_each   = local.tables
  table_name = each.value.name
  attributes = each.value.attributes
  hash_key   = each.value.hash_key

}