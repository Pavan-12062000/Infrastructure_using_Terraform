provider "aws" {
  region = "us-east-1"
}

module "VPC" {
  source = "./modules/VPC"
  vpc_cidr = var.vpc_cidr
}

module "SUBNET" {
  source = "./modules/Subnet"
  vpc_id = var.vpc_id
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone

  depends_on = [ aws_vpc.myvpc ]
}

module "InternetGateway" {
  source = "./modules/InternetGateway"
  vpc_id = var.vpc_id

  depends_on = [ aws_vpc.myvpc ]
}

module "RouteTable" {
  source = "./modules/RouteTable"
  vpc_id = var.vpc_id
  rt_cidr_block = var.rt_cidr_block
  gateway_id = var.gateway_id

  depends_on = [ aws_vpc.myvpc , aws_internet_gateway.myigw  ]
}

module "RouteTableAssociation" {
  source = "./modules/RouteTableAssociation"
  subnet_id = var.subnet_id
  route_table_id = var.route_table_id

  depends_on = [ aws_subnet.sub1 , aws_route_table.myrt  ]
}

module "SecurityGroup" {
  source = "./modules/SecurityGroups"
  vpc_id = var.vpc_id
  sg_cidr_blocks = var.sg_cidr_blocks

  depends_on = [ aws_vpc.myvpc  ]
}

resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-pavan"  # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file
}

module "EC2" {
  source = "./modules/EC2"
  ami_value = var.ami_value
  instance_type_value = var.instance_type_value
  key_name = aws_key_pair.example.key_name
  security_group_id = var.security_group_id
  subnet_id_value = var.subnet_id

  depends_on = [ aws_key_pair.example ]
}