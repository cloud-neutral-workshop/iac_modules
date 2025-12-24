variable "bootstrap_config_path" {
  description = "Path to the bootstrap account configuration YAML"
  type        = string

  validation {
    condition     = var.bootstrap_config_path != null && trimspace(var.bootstrap_config_path) != ""
    error_message = "Set bootstrap_config_path (TF_CONFIG) to the bootstrap YAML file path."
  }
}
