# GCP Credentials JSON
variable "credentials" {
  description = "Google credentials path json"
  type        = "string"
  default     = ""
}

variable "project_id" {
  description = "Google Project ID to launch in"
}

variable "region" {
  description = "Google region of the DC/OS cluster"
  default     = "us-west1"
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "example"
}

variable "infra_ssh_user" {
  default = "core"
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
  version = "~> 0.1.0"

  cluster_name              = "${var.cluster_name}"
  infra_public_ssh_key_path = "${var.public_ssh_key_path}"
  infra_ssh_user            = "${var.infra_ssh_user}"
  tags                      = "${var.tags}"

  num_masters        = "1"
  num_private_agents = "3"
  num_public_agents  = "1"

  dcos_variant = "open"
  region       = "${var.region}"
  credentials  = "${var.credentials}"
  project_id   = "${var.project_id}"
}

output "cluster-address" {
  value = "${module.dcos.dcos-infrastructure.masters.loadbalancer}"
}
