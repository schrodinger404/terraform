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


resource "aws_eip" "myip" {

  domain   = "vpc"

}

resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "created from terraform"

  tags = {
    name = "example"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_myIP" {
  security_group_id = aws_security_group.example_sg.id
  cidr_ipv4         = "${aws_eip.myip.public_ip}/32" #string interpolation
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.example_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
