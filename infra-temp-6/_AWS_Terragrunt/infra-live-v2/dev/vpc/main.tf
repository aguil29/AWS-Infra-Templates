provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "local" {
    path = "dev/vpc/terraform.tfstate"
  }
}

# Intoduce module(s) here

## VPC ##
module "vpc" {
    source = "../../../infra-modules/vpc"

    env = "dev"
    zones = ["us-east-1a", "us-east-1b"]
    private_subnets = ["10.23.11.0/24", "10.23.12.0/24"]
    public_subnets = ["10.23.1.0/24", "10.23.2.0/24"]

    private_subnet_tags = {
      "kubernetes.io/role/internal-elb" = 1
      "kubernetes.io/cluster/dev-demo" = "owned"
    }

    public_subnet_tags = {
      "kubernetes.io/role/elb" = 1
      "kubernetes.io/cluster/dev-demo" = "owned"
    }
}