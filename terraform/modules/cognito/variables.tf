variable "name" {
  type        = string
  description = "Name for cognito user pool"
}

variable "mfa_configuration" {
  type        = string
  description = "mfa config for cognito"
}

variable "account_recovery_setting" {
  type = map(object({
    name     = string
    priority = number
    }
  ))
  description = "account recovery settings for cognito"
}

variable "allow_admin_create_user_only" {
  type        = string
  description = "allow admin create user only for cognito"
}

variable "email_sending_account" {
  type        = string
  description = "email sending account for cognito"
}

variable "password_policy" {
  type = object({
    minimum_length                   = number
    require_lowercase                = bool
    require_numbers                  = bool
    require_symbols                  = bool
    require_uppercase                = bool
    temporary_password_validity_days = number
  })
  description = "mfa config for cognito"
}

variable "default_email_option" {
  type        = string
  description = "default email option for cognito"
}

variable "domain_name" {
  type        = string
  description = "Domain name"
}
