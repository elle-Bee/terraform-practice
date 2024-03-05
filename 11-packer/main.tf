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

data "aws_ami" "packer_image" {
    # executable_users = ["self"]
    # most_recent = true
    # name_regex = "my-server-httpd"
	filter {
			name   = "name"
			values = ["my-server-httpd"]
		}
	owners = ["self"]
}

resource "aws_instance" "my_server" {
  ami           = data.aws_ami.packer_image.id
  instance_type = "t2.micro"
	tags = {
		Name = "Server-Apache-Packer"
	}
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}