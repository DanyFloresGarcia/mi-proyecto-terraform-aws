### variables ######

variable "ami-id" {
  description = "The AMI ID to use for the EC2 instance."
  default     = "ami-029a761f237195c2c"
}

variable "instance-type" {
  description = "The instance type to use for the EC2 instance."
  default     = "t3.micro"
}

variable "server-name" {
  description = "The name of the nginx server instance."
  default     = "nginx-server"
}

variable "environment" {
  description = "The environment for the nginx server instance."
  default     = "Development"
}

### provider ######
provider "aws" {
  region = "us-west-2"
}


### resource ######
resource "aws_instance" "nginx-server" {
  ami           = var.ami-id
  instance_type = var.instance-type

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF

  key_name               = aws_key_pair.nginx-server-ssh.key_name
  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id]

  tags = {
    Name = var.server-name
    Environment = var.environment
    Owner = "danyfloresgarcia18@gmail.com"
    Team = "DevOps"
    Project = "personal-website"
  }
}


### ssh key pair and security group ######
# Create ssh: ssh-keygen -t rsa -b 2048 -f "nginx-server.key"
resource "aws_key_pair" "nginx-server-ssh" {
  key_name   = "${var.server-name}-ssh"
  public_key = file("${var.server-name}.key.pub")

  tags = {
    Name = "${var.server-name}-ssh"
    Environment = var.environment
    Owner = "danyfloresgarcia18@gmail.com"
    Team = "DevOps"
    Project = "personal-website"
  }
}

### SG ####
resource "aws_security_group" "nginx-server-sg" {
  name = "${var.server-name}-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.server-name}-sg"
    Environment = var.environment
    Owner = "danyfloresgarcia18@gmail.com"
    Team = "DevOps"
    Project = "personal-website"
  }
}

### output ######
output "server_public_ip" {
  value = aws_instance.nginx-server.public_ip
  description = "The public IP address of the nginx server instance."
}

output "server_public_dns" {
  value = aws_instance.nginx-server.public_dns
  description = "The public DNS name of the nginx server instance."
}

output "server_private_ip" {
  value = aws_instance.nginx-server.private_ip
  description = "The private IP address of the nginx server instance."
}