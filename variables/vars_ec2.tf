terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


# create web-app-server
resource "aws_instance" "web" {
  ami = "ami-08718895af4dfa033"
  instance_type = var.instance_type

  tags = {
    Name = "web-app-server"
  }
}