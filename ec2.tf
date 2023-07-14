# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# launch the ec2 instance and install website
resource "aws_instance" "edward-ec2-instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.edward-public-subnet-az1.id
  vpc_security_group_ids = [aws_security_group.edward-security-group.id]
  key_name               = "name of aws key pair"
  user_data              = file("install_httpd.sh")

  tags = {
    Name = "edward-ec2-instance"
  }
}
