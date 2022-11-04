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

data "aws_ami" "ubuntu_jammy" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Ubuntu
}