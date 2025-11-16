locals {
  account = yamldecode(
    file("${path.root}/../../config/accounts/dev.yaml")
  )
}

# 第一个正式 module：iam
module "iam" {
  source  = "../../modules/iam"
  account = local.account   # << 唯一需要传入 module 的变量
}
