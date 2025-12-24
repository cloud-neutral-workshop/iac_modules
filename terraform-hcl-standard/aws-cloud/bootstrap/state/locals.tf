locals {
  bootstrap_config_path = abspath(var.bootstrap_config_path)

  bootstrap = yamldecode(file(local.bootstrap_config_path))

  bucket_name   = local.bootstrap.state.bucket_name
  region        = local.bootstrap.region
  environment = try(local.bootstrap.environment, "bootstrap")
  tags        = try(local.bootstrap.tags, {})

  create_bucket = try(local.bootstrap.state.create_bucket, true)
  bucket_arn    = local.create_bucket ? aws_s3_bucket.state[0].arn : data.aws_s3_bucket.existing[0].arn
  bucket_id     = local.create_bucket ? aws_s3_bucket.state[0].id : data.aws_s3_bucket.existing[0].id
}
