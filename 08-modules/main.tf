terraform {
  
}

provider "aws" {
  region = "us-east-1"
}

module "apache" {
  source = ".//terraform-aws-apache-demo"
}

output "public_ip" {
  value = module.apache.public_ip
}