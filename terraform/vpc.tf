locals {
  vpcs = {
    vpc = {
      vpc_name = "main vpc"
      vpc_cidr = "10.0.0.0/16"
      private_subnets = {
        private1 = {
          az   = "${var.aws_region}a"
          cidr = "10.0.0.0/24"
          name = "Private subnet 1"
        }
        private2 = {
          az   = "${var.aws_region}b"
          cidr = "10.0.1.0/24"
          name = "Private subnet 2"
        }
      }
      public_subnets = {
        public1 = {
          az   = "${var.aws_region}a"
          cidr = "10.0.2.0/24"
          name = "Public subnet 1"
        }
      }
    }
  }
}

module "vpc" {
  source          = "./vpc"
  for_each        = local.vpcs
  vpc_name        = each.value.vpc_name
  vpc_cidr        = each.value.vpc_cidr
  public_subnets  = each.value.public_subnets
  private_subnets = each.value.private_subnets

}