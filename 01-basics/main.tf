terraform {
  backend "remote" {
    organization = "BeginnerOrg"

    workspaces {
      name = "practice-work"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
 
}

locals {
  server_name = "poggers"
}

