terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

variable "instance_type" {
  type        = string
  description = "Size of the instance"
  sensitive   = true # Obscures the value in terraform plan
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami = "ami-0a3c3a20c09d6f377"
  for_each = {
    nano  = "t2.nano"
    micro = "t2.micro"
    small = "t2.small"
  }
  instance_type = each.value
  tags = {
    name = "server_${each.key}"
  }
}

output "public_ip" {
  value = values(aws_instance.app_server)[*].public_ip
}