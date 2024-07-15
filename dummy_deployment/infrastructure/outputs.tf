#outputs from our terraform configuration

output "instance_ip" {
  value       = aws_instance.dummy_host_instance.public_ip
  description = "The public IP address of the EC2 instance"
}
