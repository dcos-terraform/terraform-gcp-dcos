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

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "dcos_license_key_contents" {
  description = "[Enterprise DC/OS] used to privide the license key of DC/OS for Enterprise Edition. Optional if license.txt is present on bootstrap node."
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

  dcos_type                 = "ee"
  dcos_license_key_contents = "${var.dcos_license_key_contents}"
  region                    = "${var.region}"
  credentials               = "${var.credentials}"
  project_id                = "${var.project_id}"
}

output "cluster-address" {
  value = "${module.dcos.dcos-infrastructure.masters.loadbalancer}"
}
