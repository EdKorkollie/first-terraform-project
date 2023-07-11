# terraform aws create vpc
resource "aws_vpc" "edward-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "edward-vpc"
  }
}

# Create internet Gateway and attach it to vpc
resource "aws_internet_gateway" "edward-internet-gateway" {
  vpc_id = aws_vpc.edward-vpc.id

  tags = {
    Name = "edward-internet-gateway"
  }
}

# Create public subnet az1
resource "aws_subnet" "edward-public-subnet-az1" {
  vpc_id                  = aws_vpc.edward-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "edward-public-subnet-az1"
  }
}

# Create public route table and add public route
resource "aws_route_table" "edward-public-route-table" {
  vpc_id = aws_vpc.edward-vpc.id

  # create public route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.edward-internet-gateway.id
  }

  tags = {
    Name = "edward-public-route-table"
  }
}

# Subnet association to the public route table
resource "aws_route_table_association" "edward-public-subnet-az1-route-table-association" {
  subnet_id      = aws_subnet.edward-public-subnet-az1.id
  route_table_id = aws_route_table.edward-public-route-table.id
}

# Create private subnet az1
resource "aws_subnet" "edward-private-subnet-az1" {
  vpc_id                  = aws_vpc.edward-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "your-region-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "edward-private-subnet-az1"
  }
}
