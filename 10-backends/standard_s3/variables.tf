variable "vpc_id" {
    type = string
}

variable "cidr_ip" {
    type = string
    description = "Provide your IP"
}

variable "public_key" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "server_name" {
    type = string
}

variable "workspace_iam_roles" {
default = {
    staging = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
    production = "arn:aws:iam::PRODUCTION-ACCOUNT-ID:role/Terraform"
    }
}