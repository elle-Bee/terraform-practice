Terraform Module to provision an EC2 instance that is running on Apache

Not intended for production use. Just to showcase custom modules on terraform registry.

```hcl
terraform {
  
}

provider "aws" {
  region = "us-east-1"
}

module "apache" {
  source = ".//terraform-aws-apache-demo"
}

output "public_ip" {
  value = module.apache.public_ip
}
```