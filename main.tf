terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # backend "s3" {
  #   bucket = "my-tfstate-utsav"
  #   key    = "tfstate"
  #   profile = "default"
  #   region = "us-west-2"
  #   encrypt = true
  # }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

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
