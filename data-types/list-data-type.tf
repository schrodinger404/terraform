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


/* 
Best practice is to define all the variables in a variable.tf file and variable values in a terraform.tfvars
For gitHub documentation and better understanding I have defined these variable in the main file
*/

variable "instance_type" {
    type = list(string)
    default = ["t2.micro", "t2.small", "t2.large"]
}

variable "environment" {

    default = "dev"
  
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Open port 80"

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_port80" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for webApp created using terraform"

  tags = {
    Name = "web_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080" {
  security_group_id = aws_security_group.web_sg.id # cross reference attributes
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 9000
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_instance" "web-server" {
  ami           = "ami-123"

# conditional expression & accessing the list from variables.tf file
  instance_type = var.environment == "dev" ? var.instance_type[0] : var.instance_type[1] 

# list data type passing to vpc_security_group_ids
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}", "${aws_security_group.web_sg.id}"] 
}


output "instance_type" {

  value = aws_instance.web-server.instance_type
  
}