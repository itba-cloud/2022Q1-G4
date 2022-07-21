variable "bucket_id" {
  type        = string
  description = "Id of bucket containing lambda function"
}

variable "bucket_object_key" {
  type        = string
  description = "Key of object containg lambda function"
}

variable "memory_size" {
  default     = "128"
  description = "Memory size for lambda function"
  type        = number
}

variable "runtime" {
  type        = string
  description = "Runtime enviroment for lambda"
}

variable "handler" {
  type        = string
  description = "Lmbda function's handler"
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Timeout for lambda function"
}

variable "security_group_ids" {
  type        = list(any)
  default     = []
  description = "List of security groups for lambda"
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "List of subnets to attach lambda"
}

variable "role" {
  type        = string
  default     = "arn:aws:iam::969205814093:role/LabRole"
  description = "Role arn for lambda function"
}

variable "env_vars" {
  type        = map(map(string))
  default     = {}
  description = "Enviroment variables for lambda function"
}

variable "file_path" {
  type        = string
  description = "Path to zip containg lambda"
}

variable "vpc_config" {
  default     = false
  type        = bool
  description = "Atach lambda to vpc? "
}

variable "function_name" {
  type        = string
  description = "Lambda function name"
}