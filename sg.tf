resource "aws_security_group" "allow_blockchain_port" {
  name        = "allow_blockchain_port"
  description = "Allow TCP blockchain inbound traffic"
  vpc_id      = data.aws_vpc.blockchain_vpc.id

  ingress {
    description      = "Port for Blockchain"
    from_port        = var.blockchain_port
    to_port          = var.blockchain_port
    protocol         = "tcp"
    cidr_blocks      = var.sg_cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.sg_cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_blockchain_port"
  }
}

resource "aws_security_group" "allow_blockexplorer_port" {
  name        = "allow_blockexplorer_port"
  description = "Allow TCP blockexplorer inbound traffic"
  vpc_id      = data.aws_vpc.blockchain_vpc.id

  ingress {
    description      = "Port for blockexplorer"
    from_port        = var.blockexplorer_port
    to_port          = var.blockexplorer_port
    protocol         = "tcp"
    cidr_blocks      = var.sg_cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.sg_cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_blockexplorer_port"
  }
}