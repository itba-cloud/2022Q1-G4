variable "domain_name" {
    description = "Domain name for cloudfront distribution"
    type = string
}

variable "origin_id" {
    description = "Origin id"
    type = string
}

variable "comment" {
    default = ""
    type = string
    description = "A comment for the cloudfront distribution"
}

variable "default_root_object" {
    default = "index.html"
    type = string
    description =  "Root object to return when using root url"
}
