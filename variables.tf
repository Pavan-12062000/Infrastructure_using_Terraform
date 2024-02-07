variable "vpc_cidr" {
  description = "value for vpc_cidr"
}

variable "vpc_id" {
    description = "value for vpc_id"
    default = aws_vpc.myvpc.id
}

variable "availability_zone" {
  description = "value for availability_zone"
}

variable "subnet_cidr_block" {
  description = "value for subnet_cidr_block"
}

variable "rt_cidr_block" {
  description = "value for rt_cidr_block"
}

variable "gateway_id" {
  description = "value for gateway_id"
  default = aws_internet_gateway.igw.id
}

variable "subnet_id" {
  description = "value for subnet_id"
  default = aws_subnet.sub1.id
}

variable "route_table_id" {
  description = "value for route_table_id"
  default = aws_route_table.rt.id
}

variable "sg_cidr_blocks" {
  description = "value for sg_cidr_blocks"
}

variable "ami_value" {
  description = "value for ami_value"
}

variable "instance_type_value" {
  description = "value for instance_type_value"
}

variable "security_group_id" {
  description = "value for security_group_id"
  default = aws_security_group.sg.id
}