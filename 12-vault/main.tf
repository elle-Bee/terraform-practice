terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

data "vault_generic_secret" "aws_creds" {
    path = "secret/aws"
}

provider "aws" {
  region  = data.vault_generic_secret.aws_creds.data["region"]
  access_key = data.vault_generic_secret.aws_creds.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_creds.data["aws_secret_access_key"]
}

resource "aws_instance" "my_server" {
  ami = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.nano"
  tags = {
    name = "my-server"
  }
}