data "aws_caller_identity" "current" {}

locals {
  current_account        = format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)
  only_pull_accounts     = formatlist("arn:aws:iam::%s:root", var.only_pull_accounts)
  push_and_pull_accounts = formatlist("arn:aws:iam::%s:root", var.push_and_pull_accounts)

  private_repos = {
    for name, config in var.repo_details :
    name => config if config.repository_type == "private"
  }

  public_repos = {
    for name, config in var.repo_details :
    name => config if config.repository_type == "public"
  }

  common_tags = merge(
    var.tags,
    {
      Customer-Code = var.ecr_tags
    }
  )
}
