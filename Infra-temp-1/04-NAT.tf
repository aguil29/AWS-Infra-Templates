resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-sa-east-1a.id

  tags = {
    Name = "nat"
    Owner = "FunkyFingerProductions"
    Planet = "Planet Rock"
  }

  depends_on = [aws_internet_gateway.igw]
}