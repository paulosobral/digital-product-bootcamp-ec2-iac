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

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ami_name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ami_owner
}