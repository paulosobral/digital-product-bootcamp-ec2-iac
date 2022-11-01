# Security Group Module:

vpc_name           = ["bockchain-network-vpc"]
vpc_public_subnet  = ["10.0.101.0/24"]
sg_cidr_blocks     = ["0.0.0.0/0"]
blockchain_port    = 8545
blockexplorer_port = 4000

# Instance Module:

ami_name             = ["amzn-ami-hvm-*-x86_64-gp2"]
ami_owner            = ["amazon"]
instance_type        = "t3.medium"
key_name             = "vockey"
monitoring           = true
iam_instance_profile = "LabInstanceProfile"