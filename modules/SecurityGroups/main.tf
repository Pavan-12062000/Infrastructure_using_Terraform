provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg" {
  name = "web"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ var.sg_cidr_blocks ]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ var.sg_cidr_blocks ]
  }

  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ var.sg_cidr_blocks ]
  }

  tags = {
    Name = "Web-sg"
  }
  
}