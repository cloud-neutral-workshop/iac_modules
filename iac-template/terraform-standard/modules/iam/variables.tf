variable "account" {
  type = object({
    account_id       = string
    name             = string
    environment      = string
    region           = string
    role_to_assume   = string
    logging_bucket   = string
    shared_vpc_account = string
    backend = object({
      bucket         = string
      key_prefix     = string
      dynamodb_table = string
    })
    tags = map(string)
  })
}

