terraform {  

}

module "aws_server" {
  source = ".//aws_submodule"
  instance_type = "t2.micro"
}