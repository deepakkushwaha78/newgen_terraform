locals {
  common_tags = merge(
    var.tags,
    {
      Customer-Code = var.secrets_manager_tags
    }
  )
}
