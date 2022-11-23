# Security Group Module:

data "aws_vpc" "blockchain_vpc" {
  filter {
    name   = "tag:Name"
    values = var.vpc_name
  }
}

data "aws_subnet" "blockchain_public_subnet" {
  filter {
    name   = "cidr-block"
    values = var.vpc_public_subnet
  }
}

# Instance Module:

data "aws_ami" "blockchain_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = var.ami_name
  }

  owners = var.ami_owner
}

# Cloudwatch Agent
data "template_file" "cloud_init_cloudwatch_agent" {
  template = file("${path.module}/cloudwatch_agent/cloud_init.yaml")

  vars = {
    cloudwatch_agent_configuration = "${var.metrics_config == "standard" ? base64encode(data.template_file.cloudwatch_agent_configuration_standard.rendered) : base64encode(data.template_file.cloudwatch_agent_configuration_advanced.rendered)}"
  }
}

data "template_file" "cloudwatch_agent_configuration_advanced" {
  template = file("${path.module}/cloudwatch_agent/cloudwatch_agent_configuration_advanced.json")

  vars = {
    aggregation_dimensions      = "${jsonencode(var.aggregation_dimensions)}"
    cpu_resources               = "${var.cpu_resources}"
    disk_resources              = "${jsonencode(var.disk_resources)}"
    metrics_collection_interval = "${var.metrics_collection_interval}"
  }
}

data "template_file" "cloudwatch_agent_configuration_standard" {
  template = file("${path.module}/cloudwatch_agent/cloudwatch_agent_configuration_standard.json")

  vars = {
    aggregation_dimensions      = "${jsonencode(var.aggregation_dimensions)}"
    cpu_resources               = "${var.cpu_resources}"
    disk_resources              = "${jsonencode(var.disk_resources)}"
    metrics_collection_interval = "${var.metrics_collection_interval}"
  }
}

data "template_cloudinit_config" "cloud_init_merged" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "userdata_part_cloudwatch.cfg"
    content      = data.template_file.cloud_init_cloudwatch_agent.rendered
    content_type = "text/cloud-config"
  }

  part {
    filename     = "userdata_part_caller.cfg"
    content      = var.userdata_part_content
    content_type = var.userdata_part_content_type
    merge_type   = var.userdata_part_merge_type
  }
}