output "loadbalancers_dns" {
  value = [aws_lb.web_load_balancer.dns_name]
}