resource "aws_route_table" "main" {
  count  = length(var.subnet_ids)
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_table_names[count.index]
  }
}

resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.main[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.main[1].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table_association" "main" {
  count          = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.main[count.index].id
}