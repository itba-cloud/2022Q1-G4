locals {
  security_groups = {
    lambda_sg = {
      name        = "lambda-sg"
      description = "Open all for lambda"
      vpc_id      = module.vpc["vpc"].vpc_id
      ingress_rules = {
        # none = {}
        # ingress = {
        #   from_port   = 0
        #   to_port     = 0
        #   protocol    = "-1"
        #   cidr_blocks = ["0.0.0.0/0"]
        # }
      }
      egress_rules = {
        egress = {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}

module "security_group" {
  source   = "./modules/security_group"
  for_each = local.security_groups

  name          = each.value.name
  description   = each.value.description
  vpc_id        = each.value.vpc_id
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
}