provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "Development"
      Owner       = "Grupo 4"
      Project     = "Serverles cv builder"
    }
  }
}

provider "archive" {}