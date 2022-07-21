variable "domain_name" {
  description = "Domain name for cloudfront distribution"
  type        = string
}

variable "origin_id" {
  description = "Origin id"
  type        = string
}

variable "comment" {
  default     = ""
  type        = string
  description = "A comment for the cloudfront distribution"
}

variable "default_root_object" {
  default     = "index.html"
  type        = string
  description = "Root object to return when using root url"
}

variable "default_cache_behavior" {
  type = object({
    allowed_methods = set(string)
    cached_methods  = set(string)
    forwarded_values = object({
      query_string = bool
      cookies      = map(string)
    })
    viewer_protocol_policy = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number
  })
  description = "Values for default cache behavior"
}

variable "ordered_cache_behavior" {
  type = map(object({
    path_pattern    = string
    allowed_methods = set(string)
    cached_methods  = set(string)
    forwarded_values = object({
      query_string = bool
      headers      = list(string)
      cookies      = map(string)
    })
    viewer_protocol_policy = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number
    compress               = bool
  }))
  description = "Values for orderd cache behavior"
}