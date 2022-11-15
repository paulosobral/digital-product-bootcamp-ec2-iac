resource "local_file" "server_blockchain_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/../02-ansible/blockchain.pem"
  file_permission = "0600"
}

resource "local_file" "ansible_hosts" {
  filename = "${path.module}/../02-ansible/hosts"
  content  = <<EOF
  [blockchain]
  ${aws_eip.blockchain_eip.public_ip}

  [blockchain:vars]
  ansible_private_key_file=./blockchain.pem
  ansible_user=ubuntu
  EOF
}

resource "local_file" "ansible_vars_default" {
  filename = "${path.module}/../02-ansible/vars-default.yaml"
  content  = <<EOF
  admin_user: ${var.admin_user}
  project_required_packages:
    - "apt-transport-https"
    - "ca-certificates"
    - "curl"
    - "gnupg-agent"
    - "software-properties-common"
    - "python3-pip"
    - "python3-setuptools"
  docker_gpg_url: ${var.docker_gpg_url}
  docker_repo: ${var.docker_repo}
  docker_packges:
    - "docker-ce=5:20.10.21~3-0~ubuntu-focal"
    - "docker-ce-cli=5:20.10.21~3-0~ubuntu-focal"
    - "containerd.io=1.6.9-1"
  docker_compose_url: ${var.docker_compose_url}
  python_docker_modules:
    - docker==6.0.1
    - docker-compose==1.29.2
  docker_compose_project_path: ${var.docker_compose_project_path}
  EOF
}

resource "local_file" "ansible_docker_compose" {
  filename = "${path.module}/../02-ansible/docker-compose.yml"
  content  = <<EOF
  version: '3.8'

  services:
    ganache-cli:
      image: 'trufflesuite/ganache'
      restart: always
      ports:
        - ${var.blockchain_port}:8545
      container_name: 'ganache_cli'

    ethereum-lite-explorer:
      depends_on:
        - ganache-cli
      image: 'alethio/ethereum-lite-explorer'
      restart: always
      ports:
        - ${var.blockexplorer_port}:80
      container_name: 'ethereum_lite_explorer'
      environment:
        APP_NODE_URL: 'http://${aws_eip.blockchain_eip.public_ip}:${var.blockchain_port}'
  EOF
}