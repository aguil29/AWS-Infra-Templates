resource "aws_subnet" "public_us_east_1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.23.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                            = "dev-public-us-east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io./cluster/dev-demo" = "owned"
  }
}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.23.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                            = "dev-public-us-east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io./cluster/dev-demo" = "owned"
  }
}

resource "aws_subnet" "private_us_east_1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.23.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name"                            = "dev-private-us-east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io./cluster/dev-demo" = "owned"
  }
}

resource "aws_subnet" "private_us_east_1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.23.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name"                            = "dev-private-us-east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io./cluster/dev-demo" = "owned"
  }
}