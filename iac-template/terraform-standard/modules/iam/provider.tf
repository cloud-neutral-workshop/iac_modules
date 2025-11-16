locals {
  account = yamldecode(
    file("${path.root}/../../config/accounts/dev.yaml")
  )
}

terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92.0"
    }
  }
}

provider "aws" {
  region = var.region

  assume_role {
    role_arn     = "local.account.role_to_assume"
    session_name = "TerraformDevSession"
  }
}
