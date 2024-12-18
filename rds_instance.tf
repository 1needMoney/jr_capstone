# rds.tf

resource "aws_db_instance" "wordpress_db_az1" {
  identifier        = "wordpress-db-az1"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "wordpress"
  username          = "admin"
  password          = "password123"  # Choose a secure password
  # subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible = false

  tags = {
    Name = "WordPressDBAZ1"
  }
}

resource "aws_db_instance" "wordpress_db_az2" {
  identifier        = "wordpress-db-az2"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "wordpress"
  username          = "admin"
  password          = "password123"  # Choose a secure password
  # subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible = false

  tags = {
    Name = "WordPressDBAZ2"
  }
}

# DB Subnet Group for RDS instances
resource "aws_db_subnet_group" "main" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = [aws_subnet.private_az1.id, aws_subnet.private_az2.id]

  tags = {
    Name = "WordPressDBSubnetGroup"
  }
}
