resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}


resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}