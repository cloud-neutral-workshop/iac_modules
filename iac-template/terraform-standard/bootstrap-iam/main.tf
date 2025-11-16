resource "aws_iam_role" "terraform_deploy_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${local.account.account_id}:root"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = merge(
    {
      Name        = var.role_name
      Environment = local.account.environment
    },
    local.account.tags
  )
}

# 当前阶段给 Admin 权限（你熟悉后可以缩小）
resource "aws_iam_role_policy_attachment" "attach_admin" {
  role       = aws_iam_role.terraform_deploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
