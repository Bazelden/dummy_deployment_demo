#Here I'll be building a basic infrastructure using Terraform which will include an ec2 instance and a security group in order to host a basic Java hello world application. Java application will be containerized using Docker or ECS and will be deployed on the ec2 instance.
# I'll then be using github actions to build the workflow which will be triggered on every push to the main branch. The workflow will include the following steps:
# 1. Checkout the code from the repository
# 2. Install Terraform
# 3. Initialize Terraform
# 4. Plan the Terraform
# 5. Apply the Terraform
# 6. Build the Docker image
# 7. Push the Docker image to the Docker Hub
# 8. SSH into the ec2 instance and pull the Docker image
# 9. Run the Docker container
# 10. Test the application
# 11. Destroy the infrastructure

# Provider
provider "aws" {
  region = var.region
}

# ec2 resource
resource "aws_instance" "dummy_host_instance" {
  ami           = "ami-026b2ae0ba2773e0a"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
  #Making sure docker installs on a new instance
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y docker
                service docker start
                usermod -a -G docker ec2-user
                docker run -d -p 80:80 docker.io/bazelden/dummy_deployment_demo:latest
                EOF

  security_groups = [aws_security_group.dummy_host_sg.name]
}


# Setting up a standard security group for ec2 instance with ingress and egress rules
resource "aws_security_group" "dummy_host_sg" {
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
    Name = "AppSecurityGroup"
  }
}



