#outputs from our terraform configuration

output "instance_ip" {
  value = aws_instance.dummy_host_instance.public_ip
}
