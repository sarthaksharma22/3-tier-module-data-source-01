output "instance_ids" {
  value = [aws_instance.web_server.id]
}
output "public_ips" {
  value = [aws_instance.web_server.public_ip]
}