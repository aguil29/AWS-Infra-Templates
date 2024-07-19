#   Display the iam users
#   output by iam user arn 
output "aws_iam_user_arns" {
    description = "This ouputs the arns associated for each iam user"
    value       = {
        for key, value in aws_iam_user.users: key => value.arn
    }  
}

# Display the iam groups
# output by the iam group arn
output "aws_iam_group_arns" {
    description = "This ouputs the arns associated for each iam group"
    value       = {
        for key, value in aws_iam_group.aws_iam_groups: key => value.arn
    }
}

# Display the name of each iam group policy
output "aws_iam_group_policies" {
    description = "This ouputs the names associated for each iam groupo"
    value       = {
        for key, value in aws_iam_group_policy.group_permissions: key => value.name
    }  
}