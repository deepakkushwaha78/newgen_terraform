output "private_repositories" {
  description = "Map of private repository names to their name, URL, and ARN."
  value = {
    for name, repo in aws_ecr_repository.private : name => {
      name = name
      url  = repo.repository_url
      arn  = repo.arn
    }
  }
}

output "public_repositories" {
  description = "Map of public repository names to their name and URL."
  value = {
    for name, repo in aws_ecrpublic_repository.public : name => {
      name = name
      url  = repo.repository_uri
    }
  }
}
