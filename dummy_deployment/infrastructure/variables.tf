variable "region" {
  description = "The AWS region to deploy the EC2 instance"
  default     = "eu-west-2"
}

variable "ssh_public_key" {
  description = "The public key to use for SSH access to the EC2 instance"
  type        = string
}
