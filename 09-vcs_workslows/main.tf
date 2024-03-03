terraform {
  
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bcket" {
  bucket = "vcs=${uid()}"
}

module "apache" {
  source = ".//terraform-aws-apache-demo"
  vpc_id = var.vpc_id
  cidr_ip = var.cidr_ip 
  public_key = var.public_key
  instance_type = var.instance_type
  server_name = var.server_name
}

output "public_ip" {
  value = module.apache.public_ip
}