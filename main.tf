provider "aws" {
  region = "us-east-1"
}

module "VPC" {
  source = "./modules/VPC"
  vpc_cidr = var.vpc_cidr
}

module "SUBNET" {
  source = "./modules/Subnet"
  vpc_id = module.VPC.myvpc_id
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone

  depends_on = [ module.VPC ]
}

module "InternetGateway" {
  source = "./modules/InternetGateway"
  vpc_id = module.VPC.myvpc_id

  depends_on = [ module.VPC ]
}

module "RouteTable" {
  source = "./modules/RouteTable"
  vpc_id = module.VPC.myvpc_id
  rt_cidr_block = var.rt_cidr_block
  gateway_id = module.InternetGateway.myigw_id

  depends_on = [ module.VPC , module.InternetGateway]
}

module "RouteTableAssociation" {
  source = "./modules/RouteTableAssociation"
  subnet_id = module.SUBNET.subnet_id
  route_table_id = module.RouteTable.myrt_id

  depends_on = [ module.SUBNET , module.RouteTable  ]
}

module "SecurityGroup" {
  source = "./modules/SecurityGroups"
  vpc_id = module.VPC.myvpc_id
  sg_cidr_blocks = var.sg_cidr_blocks

  depends_on = [ module.VPC  ]
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
  security_group_id = module.SecurityGroup.mysg_id
  subnet_id_value = module.SUBNET.subnet_id

  depends_on = [ aws_key_pair.example, module.SUBNET, module.SecurityGroup ]
}