module "blockchain_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "blockchain-server"

  ami                    = data.aws_ami.blockchain_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.server.key_name
  monitoring             = var.monitoring
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_blockchain_port.id, aws_security_group.allow_blockexplorer_port.id]
  subnet_id              = data.aws_subnet.blockchain_public_subnet.id
  iam_instance_profile   = var.iam_instance_profile

  tags = {
    Terraform = "true"
  }

}

resource "aws_eip" "blockchain_eip" {
  instance = module.blockchain_ec2_instance.id
  vpc      = true
}