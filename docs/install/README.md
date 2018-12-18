# Install DC/OS on GCP 

## Prerequisites
- [Terraform 0.11.x](https://www.terraform.io/downloads.html)
- Google Cloud Credentials. _[configure via: `gcloud auth login`](https://cloud.google.com/sdk/downloads)_
- Or Google Cloud Service Account key
- SSH Keys
- Existing Google Project. Soon automated with Terraform using project creation as documented [here.](https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform)


## Create Installer Directory

Make your directory where Terraform will download and place your Terraform infrastructure files.

```bash
mkdir dcos-installer
cd dcos-installer
```

## Initialize Terraform

Use the following command to initialize Terraform from this repository. There is no git clone of this repo required as Terraform performs this for you.

```
curl -O https://raw.githubusercontent.com/dcos-terraform/terraform-gcp-dcos/master/docs/published/main.tf
terraform init
```

## Modify main.tf variables

```bash
# edit the main.tf file
vi main.tf # change "ssh_public_key_file" to your local file ssh path and other variables you desire
```

## Setting up access to GCP Project

To access your GCP Project from terraform you have two options:

#### Install Google SDK

Run this command to authenticate to the Google Provider. This will bring down your keys locally on the machine for terraform to use.

```bash
$ gcloud auth login
$ gcloud auth application-default login
```

#### Supported Operating Systems

Here is the [list of operating systems supported](https://github.com/dcos-terraform/terraform-template-gcp-tested-oses/tree/master/platform/cloud/gcp).

#### Supported DC/OS Versions

Here is the list of DC/OS versions supported on dcos-terraform natively:

- [OSS Versions](https://github.com/dcos-terraform/terraform-template-dcos-core/tree/master/open/dcos-versions)
- [Enterprise Versions](https://github.com/dcos-terraform/terraform-template-dcos-core/tree/master/ee/dcos-versions)

**NOTE:** Master DC/OS version is not meant for production use. It is only for CI/CD testing.

To apply the configuration file and you accept all the default variables you can use this command below, otherwise you can continue along with this guide.

```bash
terraform apply
```

## Advanced YAML Configuration

The configuration templates using Terraform are designed to be flexible. Here is an example of working variables that allows deep customization by using a single main.tf file.

For advanced users with stringent requirements, paste the DC/OS flag examples in main.tf file.
The default variables inputs are tracked in the [terraform-gcp-dcos](https://registry.terraform.io/modules/dcos-terraform/dcos/gcp) terraform registry.

```bash
$ cat main.tf
...
module "dcos" {
  source  = "dcos-terraform/dcos/gcp"
  version = "~> 0.1.0"

  # additional example variables in the module
  dcos_version = "1.11.5"
  dcos_instance_os = "centos_7.3"
  num_masters = "3"
  num_private_agents = "2"
  num_public_agents = "1"
  dcos_cluster_name = "DC/OS Cluster"
  dcos_cluster_docker_credentials_enabled =  "true"
  dcos_cluster_docker_credentials_write_to_etc = "true"
  dcos_cluster_docker_credentials_dcos_owned = "false"
  dcos_cluster_docker_registry_url = "https://index.docker.io"
  dcos_use_proxy = "yes"
  dcos_http_proxy = "example.com"
  dcos_https_proxy = "example.com"
  dcos_no_proxy = <<EOF
  # YAML
   - "internal.net"
   - "169.254.169.254"
  EOF
  dcos_overlay_network = <<EOF
  # YAML
      vtep_subnet: 44.128.0.0/20
      vtep_mac_oui: 70:B3:D5:00:00:00
      overlays:
        - name: dcos
          subnet: 12.0.0.0/8
          prefix: 26
  EOF
  dcos_rexray_config = <<EOF
  # YAML
    rexray:
      loglevel: warn
      modules:
        default-admin:
          host: tcp://127.0.0.1:61003
      storageDrivers:
      - ec2
      volume:
        unmount:
          ignoreusedcount: true
  EOF
  dcos_cluster_docker_credentials = <<EOF
  # YAML
    auths:
      'https://index.docker.io/v1/':
        auth: Ze9ja2VyY3licmljSmVFOEJrcTY2eTV1WHhnSkVuVndjVEE=
  EOF
```
**NOTE:** The YAML comment is required for the DC/OS specific YAML settings.

## Configure your GCP SSH Keys

Set the private key that you will be using to your ssh-agent and set public key in terraform. This will allow you to log into to the cluster after DC/OS is deployed and also helps Terraform setup your cluster at deployment time.

```bash
$ ssh-add ~/.ssh/your_private_key.pem
```

```bash
$ cat cluster_profile.tfvars
public_ssh_key_path = "PATH/YOUR_GCP_SSH_PUBLIC_KEY.pub"
...
```

## Configure a Pre-existing Google Project

Currently terraform-dcos assumes a project already exist in GCP to start deploying your resources against. This repo soon will have support for terraform to create projects on behalf of the user soon via this document [here](https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform). For the time being a user will have to create this project before time or leverage an existing project.

```bash
$ cat cluster_profile.tfvars
gcp_project = "massive-bliss-781"
...
```

## Documentation

1. Deploying on GCP
2. [Upgrading DC/OS](./upgrade/README.md)
3. [Maintaining Nodes](./maintain/README.md)
4. [Destroy](./destroy/README.md)
