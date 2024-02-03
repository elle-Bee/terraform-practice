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

resource "aws_instance" "app_server" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = var.instance_type
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}