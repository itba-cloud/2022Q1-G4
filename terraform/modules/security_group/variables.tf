variable "name" {
  type        = string
  description = "Security group name"
}

variable "description" {
  default     = ""
  type        = string
  description = "Security group description"
}

variable "ingress_rules" {
  type        = map(any)
  description = "Map of values for ingress rules"
}

variable "egress_rules" {
  type        = map(any)
  description = "Map of values for egress rules"
}

variable "vpc_id" {
  type        = string
  description = "Id of vpc fore security group"
}