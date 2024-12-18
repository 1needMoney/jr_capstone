# auto_scaling.tf

resource "aws_iam_role" "ec2_s3_role" {
  name               = "wordpress-ec2-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "wordpress-ec2-s3-policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "arn:aws:s3:::${aws_s3_bucket.wordpress_media.bucket}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "wordpress-ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}

resource "aws_launch_configuration" "wordpress_launch_config" {
  name          = "wordpress-launch-config"
  image_id      = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI for EC2 instances
  instance_type = "t2.micro"
  
  security_groups = [aws_security_group.wordpress_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd php php-mysqlnd
              systemctl start httpd
              systemctl enable httpd
              curl -O https://wordpress.org/latest.tar.gz
              tar -xvzf latest.tar.gz
              cp -R wordpress/* /var/www/html/
              chown -R apache:apache /var/www/html/
              EOF

  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.id
}

resource "aws_auto_scaling_group" "wordpress_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.public_az1.id, aws_subnet.public_az2.id]
  launch_configuration = aws_launch_configuration.wordpress_launch_config.id
  health_check_type    = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "WordPressInstance"
    propagate_at_launch = true
  }
}
