data "aws_availability_zones" "available" {}


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




