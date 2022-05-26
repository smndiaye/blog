terraform {
  required_version = ">=1.0.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.env
      Project     = var.account
    }
  }
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = var.env
      Project     = var.account
    }
  }
}
