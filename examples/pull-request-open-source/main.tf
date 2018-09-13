# GCP Credentials JSON
variable "credentials" {
  description = "Google credentials path json"
  default     = ""
}

variable "project_id" {
  description = "Google Project ID to launch in"
}

variable "region" {
  description = "Google region of the DC/OS cluster"
  default     = "us-west1"
}

variable "name_prefix" {
  description = "Name of the DC/OS cluster"
  default     = "example"
}

variable "public_ssh_key_path" {
  description = <<EOF
Specify a SSH public key in authorized keys format (e.g. "ssh-rsa ..") to be used with the instances. Make sure you added this key to your ssh-agent
EOF
}

variable "custom_dcos_download_path" {
  description = "insert region of dcos installer script (optional)"
}

variable "dcos_version" {
  description = "Specify the availability zones to be used"
  default     = "1.11.3"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

module "dcos" {
  source  = "dcos-terraform/dcos/gcp"
  version = "~> 0.0"

  name_prefix               = "${var.name_prefix}"
  infra_public_ssh_key_path = "${var.public_ssh_key_path}"
  tags                      = "${var.tags}"

  num_masters        = "3"
  num_private_agents = "2"
  num_public_agents  = "1"

  dcos_type                 = "open"
  custom_dcos_download_path = "${var.custom_dcos_download_path}"
  dcos_version              = "${var.dcos_version}"
  region                    = "${var.region}"
  credentials               = "${var.credentials}"
  project_id                = "${var.project_id}"
}

output "cluster-address" {
  value = "${module.dcos.dcos-infrastructure.masters.loadbalancer}"
}
