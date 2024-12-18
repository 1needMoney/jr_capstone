# vpc.tf

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "WordPressVPC"
  }
}

# Public Subnet in AZ-1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnetAZ1"
  }
}

# Private Subnet in AZ-1
resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "PrivateSubnetAZ1"
  }
}

# Public Subnet in AZ-2
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnetAZ2"
  }
}

# Private Subnet in AZ-2
resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "PrivateSubnetAZ2"
  }
}
