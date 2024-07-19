# Grab code commit repository resource
resource "aws_codecommit_repository" "Repos" {
    for_each = toset(var.repo_names)
    repository_name = each.value
    description = "GitHub repo for class 5"

      # ignore tag added by CodeGuru service upon association
  lifecycle {
    ignore_changes = [
      tags["codeguru-reviewer"]
    ]
  }
}

# Grab KMS keys from repos
resource "aws_kms_key" "kms_keys" {
    for_each = toset(var.repo_names)
}