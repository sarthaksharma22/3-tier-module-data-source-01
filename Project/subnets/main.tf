data "aws_availability_zones" "available" {}

#Create Public Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-pubsub-${count.index + 1}"
    Environment = "${var.environment}"
  }
}

#Create Private Subnets
resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  count             = length(var.private_subnets_cidr)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.environment}-prisub-${count.index + 1}"
    Environment = "${var.environment}"
  }
}

#Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-pri-route-table"
    Environment = "${var.environment}"
  }
}

#Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-pub-route-table"
    Environment = "${var.environment}"
  }
}

#Create Public Route Table association
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index + 1)
  route_table_id = aws_route_table.public.id
}

#Create Private Route Table Association
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index + 1)
  route_table_id = aws_route_table.private.id
}

#Create internet gate way
resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}