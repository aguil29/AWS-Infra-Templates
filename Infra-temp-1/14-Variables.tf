## variable "common_tags"{
##   description = "common tags"
##   type = map(string) 
## }

variable "public_subnets" {
    type = list(string)
}

variable "private_subnets" {
    type = list(string)
}
