variable "vpc_id" {
    description = "Id of vpc"
    type = string
}

variable "service_name" {
    description = "Name of service"
    type = string
}

variable "route_table_ids" {
    description = "IDs of route table to asociate with vpc endpoint"
    type = list
}

variable "policy" {
    description = "Policy to asociate with vpc endpoint"
}