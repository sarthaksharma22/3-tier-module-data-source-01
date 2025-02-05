resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-pri-route-table"
    Environment = "${var.environment}"
  }
}


resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-pub-route-table"
    Environment = "${var.environment}"
  }
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index + 1)
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index + 1)
  route_table_id = aws_route_table.private.id
}
