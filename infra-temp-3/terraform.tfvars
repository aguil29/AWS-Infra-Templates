# iam-users
aws_iam_users = [
  "Clavelle", "Howard-Thibbs-III",
  "Theodore-Pendergrass","Grandmaster-Caz",
  "Charlie-Brown","Busta-Rhymes"
]

# iam-groups
aws_iam_group_members = {
    "Funky-Finger-Productions"  : ["Clavelle", "Howard-Thibbs-III"]
    "The-Blue-Notes"            : ["Theodore-Pendergrass"]
    "Cold-Crush-Brothers"       : ["Grandmaster-Caz"]
    "Leaders-Of-The-New-School" : ["Charlie-Brown", "Busta-Rhymes"]
}

#########################################################################################################
##                              JSON polices for each IAM Group                                        ##
#########################################################################################################
##     IAM Group              ||     JSON Policy File     ||          Permissions                      ##
#########################################################################################################
##      Group_1                          policy_1                   Admin privilieges                  ##
##                                                                                                     ## 
##      Group_2                          policy_2                   Allows ec2 actions:                ##
##                                                           Start, run, stop, and terminate           ## 
##                                                                  EC2 instance                       ## 
##                                                                                                     ## 
##      Group_3                          policy_3            Allow access to modify attributes         ## 
##                                                                  of an EC2 instance snapshot        ## 
##                                                                                                     ## 
##      Group_4                          policy_4            Blocks EC2 access in the eu-central-l     ##
##                                                                  (Frankfurt) region                 ## 
#########################################################################################################

json_policices = {
    ##     IAM_Group            :  JSON_Policy  ##    
    "Funky-Finger-Productions"  : "policy_1.json",
    "The-Blue-Notes"            : "policy_2.json",
    "Cold-Crush-Brothers"       : "policy_3.json",
    "Leaders-Of-The-New-School" : "policy_4.json"
}