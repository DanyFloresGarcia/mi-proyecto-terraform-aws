
terraform {
  backend "s3" {
    bucket = "terraform-nginx-test-q1323"
    key    = "terraform-nginx/terraform.tfstate"
    region = "us-west-2"
  }
}

## MODULES ####

## development module ####
module "nginx_server_development" {
  source = "./nginx_server_module"

  ami_id        = "ami-029a761f237195c2c"
  instance_type = "t3.medium"
  server_name   = "nginx-server-development"
  environment   = "development"
}


### output development ######
output "ngninx_development_public_ip" {
  value       = module.nginx_server_development.server_public_ip
  description = "The public IP address of the nginx server instance in development environment."
}

output "ngninx_development_public_dns" {
  value       = module.nginx_server_development.server_public_dns
  description = "The public DNS name of the nginx server instance in development environment."
}

output "ngninx_development_private_ip" {
  value       = module.nginx_server_development.server_private_ip
  description = "The private IP address of the nginx server instance in development environment."
}

## module qa ## 

module "nginx_server_qa" {
  source = "./nginx_server_module"

  ami_id        = "ami-029a761f237195c2c"
  instance_type = "t3.large"
  server_name   = "nginx-server-qa"
  environment   = "qa"
}

### output qa ######
output "ngninx_qa_public_ip" {
  value       = module.nginx_server_qa.server_public_ip
  description = "The public IP address of the nginx server instance in qa environment."
}

output "ngninx_qa_public_dns" {
  value       = module.nginx_server_qa.server_public_dns
  description = "The public DNS name of the nginx server instance in qa environment."
}

output "ngninx_qa_private_ip" {
  value       = module.nginx_server_qa.server_private_ip
  description = "The private IP address of the nginx server instance in qa environment."
}

### Import ###

# aws_instance.ngnix-server-legacy:
resource "aws_instance" "ngnix-server-legacy" {
  ami           = "ami-029a761f237195c2c"
  instance_type = "t2.medium"
  tags = {
    Name        = "ngnix-server-legacy"
    Environment = "staging"
    Owner       = "danyfloresgarcia18@gmail.com"
    Team        = "DevOps"
    Project     = "personal-website"
  }
  vpc_security_group_ids = [
    "sg-090ad06b0756a0fa4",
  ]
}

##Comando: terraform import aws_instance.ngnix-server-legacy i-0578cb6f6ffc00b19 ##
