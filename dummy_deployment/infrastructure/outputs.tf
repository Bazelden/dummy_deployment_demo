#outputs from our terraform configuration

output "instance_ip" {
  value       = aws_instance.dummy_host_instance.public_ip
  description = "value of the public ip of the ec2 instance"
}
