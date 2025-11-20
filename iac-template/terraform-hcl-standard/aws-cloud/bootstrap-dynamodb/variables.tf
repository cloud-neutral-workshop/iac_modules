variable "table_name" {
  description = "DynamoDB table name for Terraform state lock"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
