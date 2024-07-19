resource "aws_subnet" "private-eu-central-1a" {
  vpc_id            = aws_vpc.istio.id
  cidr_block        = "10.47.11.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    "Name"                                      = "private-eu-central-1a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/api" = "owned"
  }
}

resource "aws_subnet" "private-eu-central-1b" {
  vpc_id            = aws_vpc.istio.id
  cidr_block        = "10.47.12.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    "Name"                                      = "private-eu-central-1b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/istio" = "owned"
  }
}

resource "aws_subnet" "public-eu-central-1a" {
  vpc_id                  = aws_vpc.istio.id
  cidr_block              = "10.47.1.0/24"
  availability_zone       = "eu-central-1a"



  
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-eu-central-1a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/istio" = "owned"
  }
}

resource "aws_subnet" "public-eu-central-1b" {
  vpc_id                  = aws_vpc.istio.id
  cidr_block              = "10.47.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-eu-central-1b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/istio" = "owned"
  }
}
