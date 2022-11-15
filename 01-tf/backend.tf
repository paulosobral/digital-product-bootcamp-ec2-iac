terraform {
  backend "s3" {
    bucket = "terraform-state-blockchain-network"
    key    = "terraform-ec2.tfstate"
    region = "us-east-1"
  }
}