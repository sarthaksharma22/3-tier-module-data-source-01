output "security_group_ids" {
  value = [aws_security_group.Webservers_sg.id,aws_security_group.Appservers_sg.id,aws_security_group.alb_sg.id, aws_security_group.mysql_sg.id]
}