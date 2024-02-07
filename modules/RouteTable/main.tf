provider "aws" {
  region = "us-east-1"
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.rt_cidr_block
    gateway_id = var.gateway_id
  }
}