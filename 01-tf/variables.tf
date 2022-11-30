# Security Group Module:

variable "vpc_name" {
  type = list(string)
}

variable "vpc_public_subnet" {
  type = list(string)
}

variable "sg_cidr_blocks" {
  type = list(string)
}

variable "blockchain_port" {
  type = number
}

variable "blockexplorer_port" {
  type = number
}

# Instance Module:

variable "ami_name" {
  type = list(string)
}

variable "ami_owner" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "monitoring" {
  type = bool
}

variable "iam_instance_profile" {
  type = string
}

# Ansible Config:

variable "admin_user" {
  type = string
}

variable "server_blockchain_key_filename" {
  type = string
}

variable "docker_gpg_url" {
  type = string
}

variable "docker_repo" {
  type = string
}

variable "docker_compose_url" {
  type = string
}

variable "docker_compose_project_path" {
  type = string
}

variable "project_required_packages" {
  type = list(string)
}

variable "docker_packages" {
  type = list(string)
}

variable "python_docker_modules" {
  type = list(string)
}

# Docker Compose Config:

variable "blockchain_image" {
  type = string
}

variable "blockexplorer_image" {
  type = string
}

variable "blockchain_default_balance_ether" {
  type = string
}

variable "blockchain_network_id" {
  type = string
}

# Cloudwatch Agent

variable "aggregation_dimensions" {
  description = "Specifies the dimensions that collected metrics are to be aggregated on."
  type        = list(any)

  default = [
    ["InstanceId"],
    ["AutoScalingGroupName"],
  ]
}

variable "cpu_resources" {
  description = "Specifies that per-cpu metrics are to be collected. The only allowed value is *. If you include this field and value, per-cpu metrics are collected."
  type        = string
  default     = "\"resources\": [\"*\"],"
}

variable "disk_resources" {
  description = "Specifies an array of disk mount points. This field limits CloudWatch to collect metrics from only the listed mount points. You can specify * as the value to collect metrics from all mount points. Defaults to the root / mountpount."
  type        = list(any)
  default     = ["/"]
}

variable "metrics_collection_interval" {
  description = <<EOF
  Specifies how often to collect the cpu metrics, overriding the global metrics_collection_interval specified in the agent section of the configuration file. If you set this value below 60 seconds, each metric is collected as a high-resolution metric.
EOF

  type    = string
  default = 60
}

variable "userdata_part_content" {
  description = "The user data that should be passed along from the caller of the module."
  type        = string
  default     = ""
}

variable "userdata_part_content_type" {
  description = "What format is userdata_part_content in - eg 'text/cloud-config' or 'text/x-shellscript'."
  type        = string
  default     = "text/cloud-config"
}

variable "userdata_part_merge_type" {
  description = "Control how cloud-init merges user-data sections."
  type        = string
  default     = "list(append)+dict(recurse_array)+str()"
}