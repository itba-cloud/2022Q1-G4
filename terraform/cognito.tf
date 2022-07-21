locals {
  cognito_pools = {
    main_pool = {
      name              = "main_user_pool"
      domain_name       = var.website
      mfa_configuration = "OFF"
      account_recovery_setting = {
        recovery_mechanism = {
          name     = "admin_only"
          priority = 1
        }
      }
      allow_admin_create_user_only = false
      email_sending_account        = "COGNITO_DEFAULT"
      password_policy = {
        minimum_length                   = 8
        require_lowercase                = false
        require_numbers                  = false
        require_symbols                  = false
        require_uppercase                = false
        temporary_password_validity_days = 7
      }
      default_email_option = "CONFIRM_WITH_CODE"
    }
  }
}

module "cognito" {
  source   = "./modules/cognito"
  for_each = local.cognito_pools

  name                         = each.value.name
  mfa_configuration            = each.value.mfa_configuration
  account_recovery_setting     = each.value.account_recovery_setting
  allow_admin_create_user_only = each.value.allow_admin_create_user_only
  email_sending_account        = each.value.email_sending_account
  password_policy              = each.value.password_policy
  default_email_option         = each.value.default_email_option
  domain_name                  = each.value.domain_name
}