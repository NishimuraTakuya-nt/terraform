resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id

  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}