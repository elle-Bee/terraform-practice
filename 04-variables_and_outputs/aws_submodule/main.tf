variable "instance_type" {
  type = string
  description = "Size of the instance"
  sensitive = true # Obscures the value in terraform plan\

  validation {
    condition = can(regex("^t2.", var.instance_type))
    error_message = "The instance must be a t2 type EC2 instance." 
  } 
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

locals {
  ami = "ami-0a3c3a20c09d6f377"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}