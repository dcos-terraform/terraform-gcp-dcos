# terraform gcp dcos

Convenience wrapper for GCP

## Deploy DC/OS on GCP using Terraform

Get started with using this module by reading the documentation here: [README.md](https://github.com/dcos-terraform/terraform-gcp-dcos/tree/master/docs)

## Usage

```hcl
module "dcos" {
  source  = "dcos-terraform/dcos/gpp"
  version = "~> 0.1"

  cluster_name = "mydcoscluster"
  infra_public_ssh_key_path = "~/.ssh/key.pub"

  num_masters = "3"
  num_private_agents = "2"
  num_public_agents = "1"

  dcos_variant = "open"
  # dcos_license_key_contents = ""
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| billing_account | GCP Builing Account | string | `` | no |
| bootstrap_dcos_instance_os | Bootstrap node tested OSes image | string | `` | no |
| bootstrap_disk_size | Bootstrap node disk size (gb) | string | `` | no |
| bootstrap_disk_type | Bootstrap node disk type. Can be either "pd-ssd", "local-ssd", or "pd-standard". | string | `` | no |
| bootstrap_image | Bootstrap node OS image | string | `` | no |
| bootstrap_machine_type | Bootstrap node machine type | string | `` | no |
| bootstrap_public_ssh_key_path | Bootstrap Node Public SSH Key | string | `` | no |
| bootstrap_ssh_user | Bootstrap node SSH User | string | `` | no |
| credentials | GCP Credentials JSON | string | - | yes |
| custom_dcos_download_path | insert location of dcos installer script (optional) | string | `` | no |
| dcos_cluster_name | Name of the DC/OS cluster | string | `dcos-example` | no |
| dcos_license_key_contents | [Enterprise DC/OS] used to privide the license key of DC/OS for Enterprise Edition. Optional if license.txt is present on bootstrap node. | string | `` | no |
| dcos_variant | DCOS type: 'ee' or 'open' | string | `open` | no |
| dcos_version | DCOS Version | string | `1.11.4` | no |
| infra_dcos_instance_os | Global Infra Tested OSes Image | string | `` | no |
| infra_disk_size | Global Infra Disk Size | string | `` | no |
| infra_disk_type | Global Infra Disk Type | string | `` | no |
| infra_machine_type | Global Infra Machine Type | string | `` | no |
| infra_public_ssh_key_path | Global Infra Public SSH Key | string | `` | no |
| infra_ssh_user | Global Infra SSH User | string | `` | no |
| master_dcos_instance_os | Master node tested OSes image | string | `` | no |
| master_disk_size | Master node disk size (gb) | string | `` | no |
| master_disk_type | Master node disk type. Can be either "pd-ssd", "local-ssd", or "pd-standard". | string | `` | no |
| master_image | Master node OS image | string | `` | no |
| master_machine_type | Master node machine type | string | `` | no |
| master_public_ssh_key_path | Master node Public SSH Key | string | `` | no |
| master_ssh_user | Master node SSH User | string | `` | no |
| name_prefix |  | string | - | yes |
| num_masters | Number of Masters | string | `1` | no |
| num_private_agents | Number of Private Agents | string | `1` | no |
| num_public_agents | Number of Public Agents | string | `1` | no |
| org_id | GCP Org ID | string | `` | no |
| private_agent_dcos_instance_os | Private agent node tested OSes image | string | `` | no |
| private_agent_disk_size | Private agent node disk size (gb) | string | `` | no |
| private_agent_disk_type | Private agent node disk type. Can be either "pd-ssd", "local-ssd", or "pd-standard". | string | `` | no |
| private_agent_image | Private agent node OS image | string | `` | no |
| private_agent_machine_type | Private agent node machine type | string | `` | no |
| private_agent_public_ssh_key_path | Private Agent node Public SSH Key | string | `` | no |
| private_agent_ssh_user | Private Agent ndoe SSH User | string | `` | no |
| project_id | Existing Project ID | string | `` | no |
| public_agent_dcos_instance_os | Public Agent node tested OSes image | string | `` | no |
| public_agent_disk_size | Public agent disk size (gb) | string | `` | no |
| public_agent_disk_type | Public agent node disk type. Can be either "pd-ssd", "local-ssd", or "pd-standard". | string | `` | no |
| public_agent_image | Public agent node OS image | string | `` | no |
| public_agent_machine_type | Public agent machine type | string | `` | no |
| public_agent_public_ssh_key_path | Public Agent node Public SSH Key | string | `` | no |
| public_agent_ssh_user | Public Agent node SSH User | string | `` | no |
| region | GCP Region | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| dcos-infrastructure.bootstrap.dcos_instance_os | Bootstrap node tested OSes image |
| dcos-infrastructure.bootstrap.disk_size | Deployed Bootstrap disk size |
| dcos-infrastructure.bootstrap.disk_type | Deployed Bootstrap disk type |
| dcos-infrastructure.bootstrap.image | Deployed bootstrap image |
| dcos-infrastructure.bootstrap.machine_type | Deployed bootstrap machine type |
| dcos-infrastructure.bootstrap.private_ip | Bootstrap private ip |
| dcos-infrastructure.bootstrap.public_ip | Bootstrap public ip |
| dcos-infrastructure.bootstrap.ssh_user | Deployed bootstrap agent SSH user |
| dcos-infrastructure.dcos_version | DCOS Version |
| dcos-infrastructure.masters.dcos_instance_os | Master node tested OSes image |
| dcos-infrastructure.masters.disk_size | Deployed master disk size |
| dcos-infrastructure.masters.disk_type | Deployed master disk type |
| dcos-infrastructure.masters.image | Deployed master image |
| dcos-infrastructure.masters.machine_type | Deployed master machine type |
| dcos-infrastructure.masters.private_ips | masters private ip |
| dcos-infrastructure.masters.public_ips | masters public ip |
| dcos-infrastructure.masters.ssh_user | Deployed masters agent SSH user |
| dcos-infrastructure.name_prefix | Deployed Name Prefix |
| dcos-infrastructure.num_masters | Number of Masters |
| dcos-infrastructure.num_private_agents | Number of private agents |
| dcos-infrastructure.num_public_agents | Number of public agents |
| dcos-infrastructure.private_agents.dcos_instance_os | Private agent node tested OSes image |
| dcos-infrastructure.private_agents.disk_size | Deployed private agent disk size |
| dcos-infrastructure.private_agents.disk_type | Deployed private agent disk type |
| dcos-infrastructure.private_agents.image | Deployed private agent image |
| dcos-infrastructure.private_agents.machine_type | Deployed private agent machine type |
| dcos-infrastructure.private_agents.private_ips | private_agent private ip |
| dcos-infrastructure.private_agents.public_ips | private_agent public ip |
| dcos-infrastructure.private_agents.ssh_user | Deployed private agent SSH user |
| dcos-infrastructure.public_agents.dcos_instance_os | Public Agent node tested OSes image |
| dcos-infrastructure.public_agents.disk_size | Deployed public agent disk size |
| dcos-infrastructure.public_agents.disk_type | Deployed public agent disk type |
| dcos-infrastructure.public_agents.image | provided public agent OS image |
| dcos-infrastructure.public_agents.machine_type | Deployed public agent machine type |
| dcos-infrastructure.public_agents.private_ips | public_agent private ip |
| dcos-infrastructure.public_agents.public_ips | public_agent public ip |
| dcos-infrastructure.public_agents.ssh_user | Deployed public agent SSH user |
| dcos-infrastructure.region | GCP Region |
