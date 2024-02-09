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
  alias   = "east"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
  alias   = "west"
}

data "aws_ami" "east-amazon-linux-2" {
  most_recent = true
  provider    = aws.east
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "west-amazon-linux-2" {
  provider    = aws.west
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "east_server" {
  ami           = data.aws_ami.east-amazon-linux-2.id
  instance_type = "t2.micro"
  provider      = aws.east
  tags = {
    name = "server_east"
  }
}

resource "aws_instance" "west_server" {
  ami           = data.aws_ami.west-amazon-linux-2.id
  instance_type = "t2.micro"
  provider      = aws.west
  tags = {
    name = "server_west"
  }
}