variable "ami_id" {
  default = "ami-007855ac798b5175e"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "vpc_id" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "public_subnet_id" {
  type = string
}
variable "ec2_id" {
   type = string
}