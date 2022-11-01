module "blockchain_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "blockchain-sg"
  description = "Security group para o servidor blockchain"
  vpc_id      = data.aws_vpc.catapimba_vpc.id

  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules
}

module "blockchain_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Blockchain-Server"

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = var.monitoring
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  subnet_id              = data.aws_subnet.catapimba_public_subnet.id
  iam_instance_profile   = var.iam_instance_profile
  #user_data              = data.template_file.user_data_file.rendered

  tags = {
    Terraform = "true"
  }

}

resource "aws_eip" "blockchain_eip" {
  instance = module.jenkins_ec2_instance.id
  vpc      = true
}