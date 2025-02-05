output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "public_subnets_cidr" {
  value = aws_subnet.public_subnet[*].cidr_block
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}
output "private_subnets_cidr" {
  value = aws_subnet.private_subnet[*].cidr_block
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet[*].id
}