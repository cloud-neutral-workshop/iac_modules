variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_name" {
  type        = string
  description = "Which account configuration to load (e.g., dev)"
}

variable "role_name" {
  type        = string
  description = "IAM role name to create (e.g., TerraformDeployRole-Dev)"
}

locals {
  account = yamldecode(
    file("${path.root}/../config/accounts/${var.account_name}.yaml")
  )
}

