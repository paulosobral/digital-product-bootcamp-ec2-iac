# Security Group Module:

vpc_name           = ["bockchain-network-vpc"]
vpc_public_subnet  = ["10.0.101.0/24"]
sg_cidr_blocks     = ["0.0.0.0/0"]
blockchain_port    = 8545
blockexplorer_port = 80

# Instance Module:

ami_name             = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
ami_owner            = ["099720109477"] # Ubuntu
instance_type        = "t3.medium"
key_name             = "vockey"
monitoring           = true
iam_instance_profile = "LabInstanceProfile"

# Ansible Config:
admin_user                  = "ubuntu"
docker_gpg_url              = "https://download.docker.com/linux/ubuntu/gpg"
docker_repo                 = "deb https://download.docker.com/linux/ubuntu focal stable"
docker_compose_url          = "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-linux-x86_64"
docker_compose_project_path = "~/digital-product-bootcamp-blockchain-docker"