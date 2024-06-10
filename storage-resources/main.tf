resource "aws_ebs_volume" "my-ebs" {
   
   availability_zone  = "us-east-1a"
  size              = var.size
   
  tags = {
    Name = var.name
  }
}
resource "aws_volume_attachment" "ebs-attach" {
 device_name = "/dev/sdd"
 volume_id = aws_ebs_volume.my-ebs.id
 instance_id  = var.ec2_id
}
resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.my-ebs.id

  tags = {
    Name = "HelloWorld_snap"
  }
}


