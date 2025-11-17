locals {
  account = yamldecode(
    file("${path.root}/../config/accounts/${var.account_name}.yaml")
  )
}

#
# IAM Role: Terraform Deploy Role
# ----------------------------------------
resource "aws_iam_role" "terraform_deploy_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${local.account.account_id}:user/${var.terraform_user_name}"
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

# 可选：当前阶段保持你原来的 Admin full access
# （未来你可以把它缩到最小权限）
resource "aws_iam_role_policy_attachment" "attach_admin" {
  role       = aws_iam_role.terraform_deploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#
# IAM User for Terraform (AK/SK)
# ----------------------------------------
resource "aws_iam_user" "terraform_user" {
  name = var.terraform_user_name
}

#
# IAM User Policy: 最小权限
# ----------------------------------------
resource "aws_iam_user_policy" "terraform_user_policy" {
  name = "${var.terraform_user_name}-iac-policy"
  user = aws_iam_user.terraform_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # 允许 Assume TerraformDeployRole
      {
        Effect = "Allow",
        Action = [
          "sts:AssumeRole"
        ],
        Resource = aws_iam_role.terraform_deploy_role.arn
      },

      # S3: Terraform state bucket
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::svc-plus-iac-state"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::svc-plus-iac-state/*"
      },

      # DynamoDB: state lock table
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem",
          "dynamodb:DescribeTable"
        ],
        Resource = "arn:aws:dynamodb:${var.region}:${local.account.account_id}:table/svc-plus-iac-state-dynamodb-lock"
      }
    ]
  })
}
