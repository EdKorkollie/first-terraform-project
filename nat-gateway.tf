# Allocate elastic ip
resource "aws_eip" "edward-eip-for-edward-nat-gateway-az1" {
  vpc = true

  tags = {
    Name = "edward-eip-for-edward-nat-gateway-az1"
  }
}

# Create nat gateway 1a
resource "aws_nat_gateway" "edward-nat-gateway-az1" {
  allocation_id = aws_eip.edward-eip-for-edward-nat-gateway-az1.id
  subnet_id     = aws_subnet.edward-public-subnet-az1.id

  tags = {
    Name = "edward-nat-gateway-az1"
  }

  # Ensure proper ordering
  depends_on = [aws_internet_gateway.edward-internet-gateway]
}

# Create edward-private-route-table-az1  add edward-nat-gateway-az1
resource "aws_route_table" "edward-private-route-table-az1" {
  vpc_id = aws_vpc.edward-vpc.id

  # create public route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.edward-nat-gateway-az1.id
  }

  tags = {
    Name = "edward-private-route-table-az1"
  }
}

# Subnet association to the public route table
resource "aws_route_table_association" "edward-private-subnet-az1-edward-private-route-table-az1-association" {
  subnet_id      = aws_subnet.edward-private-subnet-az1.id
  route_table_id = aws_route_table.edward-private-route-table-az1.id
}
