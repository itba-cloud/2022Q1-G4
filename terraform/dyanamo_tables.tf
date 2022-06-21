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
  source = "./dynamo_table"

  for_each   = local.tables
  table_name = try(each.value.name, "")
  attributes = try(each.value.attributes, {})
  hash_key   = try(each.value.hash_key, "")

}