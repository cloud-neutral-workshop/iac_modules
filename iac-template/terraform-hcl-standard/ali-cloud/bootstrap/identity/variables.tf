variable "region" {
  description = "Alibaba Cloud region"
  type        = string
  default     = "cn-hangzhou"
}

variable "access_key" {
  description = "Alibaba Cloud Access Key ID"
  type        = string
  default     = null
}

variable "secret_key" {
  description = "Alibaba Cloud Access Key Secret"
  type        = string
  default     = null
  sensitive   = true
}

variable "security_token" {
  description = "Optional security token when using STS credentials"
  type        = string
  default     = null
  sensitive   = true
}

variable "ram_role_arn" {
  description = "Optional RAM role ARN to assume for operations"
  type        = string
  default     = null
}

variable "session_name" {
  description = "Session name when assuming a RAM role"
  type        = string
  default     = "terraform"
}

variable "account_id" {
  description = "Alibaba Cloud account ID used for trust policy"
  type        = string
}

variable "role_name" {
  description = "Name of RAM role used by Terraform"
  type        = string
  default     = "TerraformExecutionRole"
}

variable "policy_name" {
  description = "Custom policy name granting Terraform permissions"
  type        = string
  default     = "TerraformAdministrator"
}

variable "user_name" {
  description = "Name of RAM user for Terraform automation"
  type        = string
  default     = "terraform"
}
