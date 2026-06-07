
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