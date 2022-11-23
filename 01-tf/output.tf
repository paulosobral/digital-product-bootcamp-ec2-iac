output "blockexplorer_aws_elastic_ip" {
  value       = "http://${aws_eip.blockchain_eip.public_ip}:${var.blockexplorer_port}"
  description = "Public IP address of the Blockexplorer instance. Access with the HTTP protocol. Example: http://44.206.118.193:4000"
}

output "blockchain_aws_elastic_ip" {
  value       = "http://${aws_eip.blockchain_eip.public_ip}:${var.blockchain_port}"
  description = "Public IP address of the Blockchain instance. Access with the HTTP protocol. Example: http://44.206.118.193:8545"
}
