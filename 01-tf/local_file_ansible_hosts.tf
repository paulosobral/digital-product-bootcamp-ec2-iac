resource "local_file" "foo" {
  filename = "${path.module}/../02-ansible/hosts"
  content  = <<EOF
  [blockchain]
  ${aws_eip.blockchain_eip.public_ip}

  [blockchain:vars]
  ansible_private_key_file=./blockchain.pem
  ansible_user=ec2-user
  EOF
}