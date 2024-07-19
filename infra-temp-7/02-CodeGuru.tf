# Grab codeguru repo association
resource "aws_codegurureviewer_repository_association" "Revue_repos" {
  for_each = toset(var.repo_names)
  repository {
    codecommit {        
      name = aws_codecommit_repository.Repos[each.value].repository_name
    }
  }
  kms_key_details {
    encryption_option = "CUSTOMER_MANAGED_CMK"
    kms_key_id        = aws_kms_key.kms_keys[each.value].key_id
  }
}