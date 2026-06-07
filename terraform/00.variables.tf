### variables ######

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  default     = "ami-029a761f237195c2c"
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance."
  default     = "t3.micro"
}

variable "server_name" {
  description = "The name of the nginx server instance."
  default     = "nginx-server"
}

variable "environment" {
  description = "The environment for the nginx server instance."
  default     = "Development"
}

