# outputs.tf

output "load_balancer_dns_name" {
  value = aws_lb.wordpress_lb.dns_name
  description = "DNS name of the Load Balancer"
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
  description = "RDS MySQL Database endpoint"
}
