# Data source to fetch the AMI information
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Resource block to create the EC2 instance
resource "aws_instance" "webserver-ec2" {
  # Changed 'ami' to use the specific 'id' attribute from the 'data.aws_ami.ubuntu' object
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id     = var.public_subnet_id
  availability_zone = "us-east-1a"
  # provider = aws.us-east-1
  tags = {
    Name = "web_server-ec2"
  }

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install nginx1 -y 
  sudo systemctl enable nginx
  sudo systemctl start nginx
  EOF
}
