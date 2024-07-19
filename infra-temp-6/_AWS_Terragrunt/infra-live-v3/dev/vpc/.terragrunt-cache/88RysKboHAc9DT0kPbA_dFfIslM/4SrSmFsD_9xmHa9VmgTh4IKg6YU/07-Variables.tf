variable "env" {
    description = "Environment name"
    type = string
}

variable "vpc_cidr_block" {
    description = "CIDR"
    type = string
    default = "10.23.0.0/16"
}

variable "zones" {
  description = "availablity zones for subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "private subnets CIDR ranges"
  type = list(string)
}

variable "public_subnets" {
  description = "public subnets CIDR ranges"
  type = list(string)
}

variable "private_subnet_tags" {
  description = "private subnet tags"
  type = map(any)
}

variable "public_subnet_tags" {
  description = "public subnet tags"
  type = map(any)
}