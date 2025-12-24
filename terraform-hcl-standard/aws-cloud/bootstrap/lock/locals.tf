locals {
  bootstrap_config_path = abspath(var.bootstrap_config_path)
  bootstrap = yamldecode(file(local.bootstrap_config_path))

  dynamodb_table_name = local.bootstrap.state.dynamodb_table_name
  region              = local.bootstrap.region
  environment         = try(local.bootstrap.environment, "bootstrap")
  tags                = try(local.bootstrap.tags, {})
}
