resource "aws_db_subnet_group" "mysql_subnet_group" {
  name        = "mysql-subnet-group"
  description = "Subnet group for MySQL RDS"
  subnet_ids  = var.subnet_ids
}

#Rds Creation
resource "aws_db_instance" "mysql_instance" {
  identifier             = "mysql-instance"
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  parameter_group_name   = var.parameter_group_name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = true
  multi_az               = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  tags = {
    Name = "${var.environment}-mysql-instance"
  }
}