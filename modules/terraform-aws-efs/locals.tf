locals {
  base_name = "${var.env}-${var.app}"

  common_tags = merge(var.tags, {
    env   = var.env
    app   = var.app
    owner = var.owner
  })
}
