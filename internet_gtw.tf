# Create an Internet Gateway
resource "aws_internet_gateway" "jr_capstone_igw" {
  vpc_id = aws_vpc.jr_wordpress_vpc.id

  tags       =  {
    name     = "jr_capstone_igw"
  }
  }