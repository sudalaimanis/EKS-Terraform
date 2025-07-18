resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "MySubnet_Public_az1"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "MySubnet_Public_az2"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_az1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "MySubnet_Private_az1"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_az2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "MySubnet_Private_az2"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_eip" "nat" {
  # For VPC EIP, no attribute is needed in recent AWS provider versions
}

resource "aws_nat_gateway" "my_natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_az1.id
  tags = {
    Name = "MyNatGateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_natgw.id
  }
  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private.id
}