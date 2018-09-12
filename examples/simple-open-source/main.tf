# GCP Credentials JSON
variable "credentials_path_json" {
  description = "Google credentials path json"
  type        = "string"
}

variable "region" {
  description = "Google region of the DC/OS cluster"
  default     = "us-west1"
}

variable "name_prefix" {
  description = "Name of the DC/OS cluster"
  default     = "dcos-example"
}

variable "public_ssh_key_path" {
  description = <<EOF
Specify a SSH public key in authorized keys format (e.g. "ssh-rsa ..") to be used with the instances. Make sure you added this key to your ssh-agent
EOF
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "list"
  default     = []
}

module "dcos" {
  source  = "dcos-terraform/dcos/gcp"
  version = "~> 0.0"

  name_prefix               = "${var.name_prefix}"
  infra_public_ssh_key_path = "${var.public_ssh_key_path}"
  tags                      = "${var.tags}"

  num_masters        = "1"
  num_private_agents = "2"
  num_public_agents  = "1"

  dcos_type             = "open"
  region                = "${var.region}"
  credentials_path_json = "${var.credentials_path_json}"
}

output "cluster-address" {
  value = "${module.dcos.dcos-infrastructure.masters.loadbalancer}"
}
