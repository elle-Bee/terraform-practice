provider "aws" {
  profile = "default"
  region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../project1/terraform.tfstate"
  }
}

module "apache-example" {
  source  = "jonasv05/apache-example/aws"
  version = "1.0.1"
  public_key = var.public_key
}

output "public_ip" {
  value = module.apache-example.public_ip
}