terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["c:/Users/mbra/.aws/config"]
  shared_credentials_files = ["c:/Users/mbra/.aws/credentials"]
  profile                  = "default"
  region                   = "us-east-1"
}

//resource "aws_key_pair" "terraform-demo" {
// key_name   = "terraform-demo"
// public_key = file("testeins.pub")
//}


resource "aws_default_vpc" "default" {}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "PORTA 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}



resource "aws_instance" "web_ngx" {
  ami           = var.iam_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.allow_tls.id
  ]

  key_name  = "testeafro"
  user_data = file("install_apache.sh")


  tags = {
    "Terraform" : "true"
  }
}


