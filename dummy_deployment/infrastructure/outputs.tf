#outputs from our terraform configuration

output "instance_ip" {
  value = aws_instance.example.public_ip
}
