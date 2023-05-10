resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"  # Specify the desired CIDR block for the VPC

  tags = {
    Name = "example-vpc"  # Optionally, specify a name for the VPC
  }
}

resource "aws_subnet" "my-subnet" {
  count = 2  # Create two subnets, change count to desired number of subnets

  cidr_block = "10.0.${count.index + 1}.0/24"  # Specify the desired CIDR block for each subnet
  vpc_id     = aws_vpc.example_vpc.id         # Reference the VPC ID created above

  tags = {
    Name = "example-subnet-${count.index + 1}"  # Optionally, specify a name for each subnet
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.example_vpc.id  # Reference the VPC ID created above

  tags = {
    Name = "example-igw"  # Optionally, specify a name for the Internet Gateway
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.example_vpc.id  # Reference the VPC ID created above

  tags = {
    Name = "example-rt"  # Optionally, specify a name for the Route Table
  }
}

resource "aws_route" "my-route" {
  route_table_id = aws_route_table.example_rt.id  # Reference the Route Table ID created above

  # Specify the desired route, such as to an Internet Gateway or a NAT Gateway
  # For example, to route all traffic to the Internet Gateway:
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example_igw.id
}

resource "aws_route_table_association" "my-rta" {
  count = 2  # Associate each subnet with the Route Table, change count to match the number of subnets

  subnet_id      = aws_subnet.example_subnet[count.index].id  # Reference the Subnet ID created above
  route_table_id = aws_route_table.example_rt.id              # Reference the Route Table ID created above
}




resource "aws_security_group" "my-sg-tf" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.my-vpc.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.my-vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# resource "aws_vpc" "my-vpc" {
#   cidr_block = "10.0.0.0/16"  # Specify the desired CIDR block for the VPC

#   tags = {
#     Name = "example-vpc"  # Optionally, specify a name for the VPC
#   }
# }

# resource "aws_subnet" "my-subnet" {
#   count = 2  # Create two subnets, change count to desired number of subnets

#   cidr_block = "10.0.${count.index + 1}.0/24"  # Specify the desired CIDR block for each subnet
#   vpc_id     = aws_vpc.example_vpc.id         # Reference the VPC ID created above

#   tags = {
#     Name = "example-subnet-${count.index + 1}"  # Optionally, specify a name for each subnet
#   }
# }

# resource "aws_internet_gateway" "my-igw" {
#   vpc_id = aws_vpc.example_vpc.id  # Reference the VPC ID created above

#   tags = {
#     Name = "example-igw"  # Optionally, specify a name for the Internet Gateway
#   }
# }

# resource "aws_route_table" "my-rt" {
#   vpc_id = aws_vpc.example_vpc.id  # Reference the VPC ID created above

#   tags = {
#     Name = "example-rt"  # Optionally, specify a name for the Route Table
#   }
# }

# resource "aws_route" "my-route" {
#   route_table_id = aws_route_table.example_rt.id  # Reference the Route Table ID created above

#   # Specify the desired route, such as to an Internet Gateway or a NAT Gateway
#   # For example, to route all traffic to the Internet Gateway:
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.example_igw.id
# }

# resource "aws_route_table_association" "my-rta" {
#   count = 2  # Associate each subnet with the Route Table, change count to match the number of subnets

#   subnet_id      = aws_subnet.example_subnet[count.index].id  # Reference the Subnet ID created above
#   route_table_id = aws_route_table.example_rt.id              # Reference the Route Table ID created above
# }

