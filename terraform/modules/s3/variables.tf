variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "acl" {
  description = "Acl type for bucket"
  type        = string
}

variable "policy" {
  description = "Policy bucket"
  type        = string
}

variable "website" {
  description = "Website mapping for bucket"
  type        = map(string)
  default     = {}
}

variable "logging" {
  description = "Bucket logging"
  type        = map(string)
  default     = {}
}

variable "with_files" {
  description = "Bucket contains files?"
  type        = bool
  default     = false
}

variable "files" {
  description = "Location of files"
  type        = map(string)
  default     = {}
}

variable "template_files" {
  description = "data template files to upload"
  type        = map(any)
  default     = {}
}