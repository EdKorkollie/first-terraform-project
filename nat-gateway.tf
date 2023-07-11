# Allocate elastic ip
resource "aws_eip" "edward-eip-for-your-nat-gateway-az1" {
  vpc = true

  tags = {
    Name = "edward-eip-for-your-nat-gateway-az1"
  }
}

# Create nat gateway 1a
resource "aws_nat_gateway" "edward-nat-gateway-az1" {
  allocation_id = aws_eip.edward-eip-for-your-nat-gateway-az1.id
  subnet_id     = aws_subnet.techmax_public_subnet_1a.id

  tags = {
    Name = "edward-nat-gateway-az1"
  }

  # Ensure proper ordering
  depends_on = [aws_internet_gateway.edward-internet-gateway]
}
