### provider ######
provider "aws" {
  region = "us-west-2"
}


### resource ######
resource "aws_instance" "nginx-example" {
  ami           = "ami-029a761f237195c2c"
  instance_type = "t3.micro"

  tags = {
    Name = "NginxExampleInstance"
  }
}