terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.micro"
  tags = {
    name = "app-server"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "elleBee-s3bucket"
  depends_on = [
    aws_instance.app_server
  ]
}

output "public_ip" {
  value = aws_instance.app_serverS.public_ip
}