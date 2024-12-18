resource "aws_db_instance" "wordpress_db_az1" {
  identifier        = "wordpress-db"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "wordpress"
  username          = "admin"
  password          = "password123"  # Choose a secure password
  subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible = false
  multi_az           = true  # Enable Multi-AZ deployment for high availability

  tags = {
    Name = "WordPressDBMultiAZ"
  }
}
