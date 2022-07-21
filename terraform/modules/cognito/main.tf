resource "aws_cognito_user_pool" "this" {
  mfa_configuration = var.mfa_configuration
  name              = var.name

  dynamic "account_recovery_setting" {
    for_each = length(var.account_recovery_setting) != 0 ? [1] : []

    content {
      dynamic "recovery_mechanism" {
        for_each = length(var.account_recovery_setting.recovery_mechanism) != 0 ? [1] : []

        content {
          name     = var.account_recovery_setting.recovery_mechanism.name
          priority = var.account_recovery_setting.recovery_mechanism.priority
        }
      }
    }
  }
  # account_recovery_setting {
  #   recovery_mechanism {
  #     name     = "admin_only"
  #     priority = 1
  #   }
  # }
  dynamic "admin_create_user_config" {
    for_each = length(var.allow_admin_create_user_only) != 0 ? [1] : []

    content {
      allow_admin_create_user_only = var.allow_admin_create_user_only
    }
  }

  dynamic "email_configuration" {
    for_each = length(var.email_sending_account) != 0 ? [1] : []

    content {
      email_sending_account = var.email_sending_account
    }
  }

  dynamic "password_policy" {
    for_each = length(var.password_policy) != 0 ? [1] : []

    content {
      minimum_length                   = var.password_policy.minimum_length
      require_lowercase                = var.password_policy.require_lowercase
      require_numbers                  = var.password_policy.require_numbers
      require_symbols                  = var.password_policy.require_symbols
      require_uppercase                = var.password_policy.require_uppercase
      temporary_password_validity_days = var.password_policy.temporary_password_validity_days
    }
  }
  dynamic "verification_message_template" {
    for_each = length(var.default_email_option) != 0 ? [1] : []

    content {
      default_email_option = var.default_email_option
    }
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain                               = var.domain_name
  user_pool_id                         = aws_cognito_user_pool.this.id 
}

resource "aws_cognito_user_pool_client" "this" {
  name = "${var.name}-client-pool"

  user_pool_id = aws_cognito_user_pool.this.id
  allowed_oauth_flows                  = ["code", "implicit", ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["openid"]
  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
  supported_identity_providers = ["COGNITO"]
}