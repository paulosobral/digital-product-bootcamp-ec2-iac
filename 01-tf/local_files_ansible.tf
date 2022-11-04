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
  admin_user: ubuntu
  project_required_packages:
    - "apt-transport-https"
    - "ca-certificates"
    - "curl"
    - "gnupg-agent"
    - "software-properties-common"
    - "python3-pip"
    - "python3-setuptools"
    - "git"
  docker_gpg_url: https://download.docker.com/linux/ubuntu/gpg
  docker_repo: deb https://download.docker.com/linux/ubuntu focal stable
  docker_packges:
    - "docker-ce"
    - "docker-ce-cli"
    - "containerd.io"
  docker_compose_url: https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-linux-x86_64
  python_docker_modules:
    - docker
    - docker-compose
  git_project_url: https://github.com/paulosobral/digital-product-bootcamp-blockchain-docker.git
  git_project_path: ~/digital-product-bootcamp-blockchain-docker
  EOF
}