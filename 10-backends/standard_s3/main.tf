terraform {
  backend "s3" {
    bucket = "terraform-backend-s3"
    key    = "terraform.tfstate"
    region = "us-east-1"
    profile = "default"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = var.workspace_iam_roles[terraform.workspace]
  }
}

resource "aws_s3_bucket" "bcket" {
  bucket = "vcs=${uid()}"
}

module "apache-example" {
  source  = "jonasv05/apache-example/aws"
  version = "1.0.1"
  public_key = var.public_key
}

output "public_ip" {
  value = module.apache.public_ip
}