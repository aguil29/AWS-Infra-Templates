output "Hello_user_"{
    value = "Use these urls to git clone into a local folder"
}

output "Repo"{
    value = {
        for key, value in aws_codecommit_repository.Repos: key => "Clone_url_https: ${value.clone_url_http}"
    }
}

output "Repo_kms_key_ids"{
    value = {
        for key, value in aws_kms_key.kms_keys: key=> value.key_id
    }
}