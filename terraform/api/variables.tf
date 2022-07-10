variable "name" {
  type = string
  description = "Name for api"
}

variable "description" {
  type = string
  default = ""
  description = "Description for api"
}

variable "invoke_arn" {
  type = string
  description = "Invoke arn of resource"
}

variable "api_path" {
  type = string
  description = "Value for api path"
}

variable "credentials" {
  type = string
  description = "Credentials to execute resource"
  default = "arn:aws:iam::969205814093:role/LabRole"
}

variable "api_env_stage_name" {
  type = string
  description = "Stage name for api"
  default = "dafault-stage"
}

variable "policy" {
    description = "Policy for api"
    type = string
}
