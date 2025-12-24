include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../state", "../lock"]
}

terraform {
  source = "${get_parent_terragrunt_dir()}/..//bootstrap/identity"
}

locals {
  tg_root     = get_env("TG_ROOT", get_parent_terragrunt_dir())
  repo_root   = abspath("${local.tg_root}/../../../../../")
  gitops_root = "${local.repo_root}/gitops"

  tf_config_env = trimspace(get_env("TF_CONFIG", ""))
  bootstrap_config_path = local.tf_config_env != "" ? (
    startswith(local.tf_config_env, "/") ? local.tf_config_env : abspath("${local.repo_root}/${local.tf_config_env}")
  ) : abspath("${local.gitops_root}/${get_env("GITOPS_BOOTSTRAP_CONFIG", "config/bootstrap.yaml")}")
}

inputs = {
  bootstrap_config_path = local.bootstrap_config_path
}
