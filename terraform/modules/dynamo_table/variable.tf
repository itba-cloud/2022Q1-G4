variable "table_name" {
  description = "Table name"
  type        = string
}

variable "attributes" {
  description = "Table attributes"
  type        = map(map(string))
}

variable "hash_key" {
  description = "Table hash key, must be definde as an attribute"
  type        = string
}
