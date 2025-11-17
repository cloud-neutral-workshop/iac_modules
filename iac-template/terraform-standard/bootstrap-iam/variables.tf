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

variable "terraform_user_name" {
  type        = string
  description = "IAM username for Terraform IAC runner"
}
