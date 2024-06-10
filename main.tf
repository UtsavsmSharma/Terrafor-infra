terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# variable "region" {}
provider "aws" {
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
  profile = "default"
  region  = "us-west-1"
  alias   = "us-west-1"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
  alias   = "us-east-1"

}


# resource "aws_key_pair" "example" {
#   key_name = "my-keypair" # Update with your desired key pair name

#   # Generate a new RSA key pair with 2048 bits
#   public_key = tls_private_key.example.public_key_openssh
# }

# resource "tls_private_key" "example" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# output "private_key_pem" {
#   value     = tls_private_key.example.private_key_pem
#   sensitive = true
# }

# output "public_key_openssh" {
#   value = tls_private_key.example.public_key_openssh
# }

module "network-resources" {
  source = "./network-resources"
  vpc_id = module.network-resources.vpc_id
}

module "security-resources" {
  source = "./security-resources"
  vpc_id = module.network-resources.vpc_id
}

module "ec2-resources" {
  source = "./ec2-resources"

  vpc_id            = module.network-resources.vpc_id
  security_group_id = module.security-resources.security_group_id
  public_subnet_id  = module.network-resources.public_subnet_id
  ec2_id            = module.ec2-resources.ec2_id

}
module "storage-resources" {
  source = "./storage-resources"
  name   = module.network-resources.public_subnet_id
  ec2_id = module.ec2-resources.ec2_id
}

# module "sqs" {
#   source        = "./sqs"
#   sqs_arn       = module.sqs.sqs_arn
#   sns_topic_arn = module.sns.sns_topic_arn
# }

# module "sns" {
#   source = "./sns"
#   # aws_sns_arn = module.sns.aws_sns_arn
#   sqs_arn       = module.sqs.sqs_arn
#   sns_topic_arn = module.sns.sns_topic_arn

# }
# resource "aws_s3_bucket" "my_bucket" {
#   # Configuration will be filled in after import
#   provider = aws.usw
# }

