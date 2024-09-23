/*
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
*/

variable "instance_type" {
    default = "t2.micro"
}

variable "developers" {
    type = list(string)
    default = [ "shreekant", "teja", "sigma" ]
}

resource "aws_instance" "myec2" {
    count = 3
    ami = "ami-1234"
    instance_type = var.instance_type

    tags = {
      name = "web-server-${count.index}"
    }
}

resource "aws_iam_user" "dev-users" {
    count = 3
    name = var.developers[count.index]
    tags = {
    role = "web-develpoer"
  }
}