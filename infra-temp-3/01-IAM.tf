# Create the iam group  membership resource

# Enroll users into the iam group
# As members of the team
resource "aws_iam_group_membership" "aws_iam_group_memberships"{
  for_each = var.aws_iam_group_members
  group    = aws_iam_group.aws_iam_groups[each.key].name
  users    = each.value
  name     = "${each.key}-team"
}

# Create the names of the iam groups
resource "aws_iam_group" "aws_iam_groups"{
  for_each = var.aws_iam_group_members
  name     = "${each.key}"
}

# Creating the names of the iam users
resource "aws_iam_user" "users"{
  for_each = toset(var.aws_iam_users)
  name     = each.value
}

# Creating the iam group policy permissions
resource "aws_iam_group_policy" "group_permissions"{
  for_each = var.json_policices
  name     = "${each.key}-permissions"
  group    = aws_iam_group.aws_iam_groups[each.key].name
  policy   = file("${path.module}/policies/${each.value}") ## read json policies
}

# Setting up Access key creation for 
# each iam user
resource "aws_iam_access_key" "aws_iam_access_keys"{
  for_each = toset(var.aws_iam_users)
  user     = aws_iam_user.users[each.value].name
}

# Creating csv files to store access and secret credentials
# from the terrafrom state file

# For each iam user, pulled from access key id and secret
# files to be exported to AWS IAM
locals {
    user_keys_csv = {
        for key, value in aws_iam_access_key.aws_iam_access_keys: key => "${value.user} Keys\naccess_key,secret_key\n${value.id},${value.secret}"
    }
}

# Create local csv files to store keys of each iam user
# files are saved in your root terraform folder
resource "local_file" "user_keys"{
  for_each = toset(var.aws_iam_users)
  content = local.user_keys_csv[each.value]
  filename = "${each.value}-keys.csv"
}