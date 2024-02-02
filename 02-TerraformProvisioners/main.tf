terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "main" {
  id = "vpc-054224cfe771ed5c8"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa key"
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}

resource "aws_security_group" "sg_myserver" {
  name        = "sg_myserver"
  description = "Server security group"
  vpc_id      = data.aws_vpc.main.id

  ingress = [
    {
      description      = "Outgoing Traffic"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${ip-address}/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
}

resource "aws_instance" "myserver" {
  ami                    = "ami-0a3c3a20c09d6f377"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_myserver.id]
  user_data              = data.template_file.user_data.rendered
  tags = {
    Name = "myserver"
  }
}

resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.myserver.id}"
  }
  depends_on = [
    aws_instance.myserver
  ]
}

output "public_ip" {
  value = aws_instance.myserver.public_ip
}