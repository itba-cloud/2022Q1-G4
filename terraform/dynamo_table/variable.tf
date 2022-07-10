variable "table_name" {
    description = "Table name"
    type = string
}

variable "attributes" {
    description = "Table attributes"
    type = map
}

variable "hash_key" {
    default = ""
    description = "Table attributes"
    type = string
}