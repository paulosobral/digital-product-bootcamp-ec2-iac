resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "server_jammy_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "blockchain.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "server" {
  key_name   = "blockchain"
  public_key = tls_private_key.ssh.public_key_openssh
}