terraform {  

}

module "aws_server" {
  source = ".//aws_server"
  instance_type = "t2.micro"
}