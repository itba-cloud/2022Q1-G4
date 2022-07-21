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
        public2 = {
          az   = "${var.aws_region}b"
          cidr = "10.0.3.0/24"
          name = "Public subnet 2"
        }
      }
      nat_gateway = {
        nat_az_a = {
          subnet_key = "public1"
        }
        nat_az_b = {
          subnet_key = "public2"
        }
      }
      private_route_table_asociation = {
        association1 = {
          nat    = "nat_az_a"
          subnet = "private1"
        }
        association2 = {
          nat    = "nat_az_b"
          subnet = "private2"
        }
      }
    }
  }
}

module "vpc" {
  source                         = "./modules/vpc"
  for_each                       = local.vpcs
  vpc_name                       = each.value.vpc_name
  vpc_cidr                       = each.value.vpc_cidr
  public_subnets                 = each.value.public_subnets
  private_subnets                = each.value.private_subnets
  nat_gateway                    = each.value.nat_gateway
  private_route_table_asociation = each.value.private_route_table_asociation
}