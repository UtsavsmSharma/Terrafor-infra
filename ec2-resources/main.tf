resource "aws_instance" "webserver-ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id     = var.public_subnet_id
   availability_zone = "us-east-1a"
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
