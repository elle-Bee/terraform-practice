terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

variable "instance_type" {
  type = string
  description = "Size of the instance"
  sensitive = true # Obscures the value in terraform plan
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = "var.instance_type"
  count = 2
  tags = {
    name = "server_${count.index}"
  }
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "elleBee-s3bucket"
  depends_on = [
    aws_instance.app_server
  ]
}

output "public_ip" {
  value = aws_instance.app_server[*].public_ip # Outputs a list of public IPs
}