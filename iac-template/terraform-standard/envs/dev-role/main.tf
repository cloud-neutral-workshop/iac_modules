locals {
  account = yamldecode(
    file("${path.root}/../../config/accounts/dev.yaml")
  )
}


data "aws_iam_policy_document" "dev_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account.account_id}:root"]
    }
  }
}

module "dev_role" {
  source = "../../modules/iam"

  name               = "dev-app-role"
  assume_role_policy = data.aws_iam_policy_document.dev_assume.json

  tags = local.account.tags
}
