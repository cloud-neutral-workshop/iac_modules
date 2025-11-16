resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.assume.json

  tags = var.tags
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["*"] # 你可以未来改为 OIDC provider 等
    }
  }
}
