resource "local_file" "server_blockchain_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/../02-ansible/${var.server_blockchain_key_filename}"
  file_permission = "0600"
}

resource "local_file" "ansible_hosts" {
  filename = "${path.module}/../02-ansible/hosts"
  content  = <<EOF
  [blockchain]
  ${aws_eip.blockchain_eip.public_ip}

  [blockchain:vars]
  ansible_private_key_file=./${var.server_blockchain_key_filename}
  ansible_user=ubuntu
  EOF
}

resource "local_file" "ansible_vars_default" {
  filename = "${path.module}/../02-ansible/vars-default.yaml"
  content  = <<EOF
  admin_user: ${var.admin_user}
  project_required_packages:
  %{for packages in var.project_required_packages~}
  - ${packages}
  %{endfor~}

  docker_gpg_url: ${var.docker_gpg_url}
  docker_repo: ${var.docker_repo}
  docker_packages:
  %{for packages in var.docker_packages~}
  - ${packages}
  %{endfor~}

  docker_compose_url: ${var.docker_compose_url}
  python_docker_modules:
  %{for packages in var.python_docker_modules~}
  - ${packages}
  %{endfor~}

  docker_compose_project_path: ${var.docker_compose_project_path}
  EOF
}

resource "local_file" "ansible_docker_compose" {
  filename = "${path.module}/../02-ansible/docker-compose.yml"
  content  = <<EOF
  version: '3.8'

  services:
    blockchain:
      image: '${var.blockchain_image}'
      restart: always
      ports:
        - ${var.blockchain_port}:8545
      container_name: 'blockchain'
      environment:
        - debug
        - verbose
        - defaultBalanceEther: '${var.blockchain_default_balance_ether}'
        - chainId: '${var.blockchain_network_id}'

    blockexplorer:
      depends_on:
        - blockchain
      image: '${var.blockexplorer_image}'
      restart: always
      ports:
        - ${var.blockexplorer_port}:80
      container_name: 'blockexplorer'
      environment:
        - APP_NODE_URL: 'http://${aws_eip.blockchain_eip.public_ip}:${var.blockchain_port}'
  EOF
}