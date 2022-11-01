terraform {
  backend "s3" {
    bucket = "terraform-state-blockchain-network"
    key    = "terraform-network.tfstate"
    region = "us-east-1"
  }
}