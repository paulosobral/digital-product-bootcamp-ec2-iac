# Security Group Module:

data "aws_vpc" "blockchain_vpc" {
  filter {
    name   = "tag:Name"
    values = var.vpc_name
  }
}

data "aws_subnet" "blockchain_public_subnet" {
  filter {
    name   = "cidr-block"
    values = var.vpc_public_subnet
  }
}

# Instance Module:

data "aws_ami" "blockchain_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = var.ami_name
  }

  owners = var.ami_owner
}

data "template_file" "user_data_file" {
  template = file("${path.module}/user_data.sh")
}