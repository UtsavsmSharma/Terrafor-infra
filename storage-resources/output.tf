output "name_ebs" {
    description = "name for resource"
    value = aws_ebs_volume.my-ebs.arn
}

output "size" {
    description = "size of ebs"
    value = "40"
  
}