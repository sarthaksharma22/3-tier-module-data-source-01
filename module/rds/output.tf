output "rds_instance_arn" {
  value = aws_db_instance.mysql_instance.arn
}
output "rds_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}
output "subnet_ids" {
  value = aws_db_subnet_group.mysql_subnet_group.subnet_ids
}
