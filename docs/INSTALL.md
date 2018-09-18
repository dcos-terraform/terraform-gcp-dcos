# Deploy DC/OS on GCP with Terraform
_Deploy automated installs and upgrades for DC/OS on GCP._

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

Run this command below to have Terraform initialized from this repository. There is **no git clone of this repo required** as Terraform performs this for you.

```
terraform init -from-module github.com/dcos-terraform/terraform-gcp-dcos
```

## Setting up access to GCP Project

To access your GCP Project from terraform you have two options:

#### Install Google SDK

Run this command to authenticate to the Google Provider. This will bring down your keys locally on the machine for terraform to use.

```bash
$ gcloud auth login
$ gcloud auth application-default login
```

### Custom terraform-dcos variables

The default variables are tracked in the [variables.tf](../variables.tf) file. Since this file can be overwritten during updates when you may run `terraform get --update` when you want to fetch new releases of DC/OS to upgrade too, its best to use the cluster_profile.tfvars and set your custom terraform and DC/OS flags there. This way you can keep track of a single file that you can use manage the lifecycle of your cluster.

To apply the configuration file, you can use this command below.

### `cluster_profile.tfvars`

```bash
# or similar depending on your environment
echo 'public_ssh_key_path = "~/.ssh/id_rsa.pub"' >> cluster_profile.tfvars
# lets set the clustername
echo 'name_prefix = "my-ee-cluster"' >> cluster_profile.tfvars
# we at mesosphere have to tag our instances with an owner and an expire date.
echo 'tags = ["prod", "staging", "kubernetes"]' >> cluster_profile.tfvars
# we have to explicitly set the version.
echo 'dcos_version = "1.10.8"' >> cluster_profile.tfvars
# we can set the azure location
echo 'region = "us-west1"' >> cluster_profile.tfvars
# set the google project id
echo 'project_id = "massive-bliss-781"' >> cluster_profile.tfvars

```

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

#### Supported Operating Systems

Here is the [list of operating systems supported](https://github.com/dcos-terraform/terraform-aws-tested-oses/tree/master/platform/cloud/aws).

#### Supported DC/OS Versions

Here is the list of DC/OS versions supported on dcos-terraform natively:

- [OSS Versions](https://github.com/dcos-terraform/terraform-template-dcos-core/tree/master/open/dcos-versions)
- [Enterprise Versions](https://github.com/dcos-terraform/terraform-template-dcos-core/tree/master/ee/dcos-versions)

**Note**: Master DC/OS version is not meant for production use. It is only for CI/CD testing.

## Configuring Enterprise DC/OS

To install Enterprise DC/OS: add these variables below in your `cluster_profile.tfvars`

```bash
# using enterprise edition
echo 'dcos_variant = "ee"' >> cluster_profile.tfvars
# paste your license key here
echo 'dcos_license_key_contents = "abcdef123456"' >> cluster_profile.tfvars
```

### Deploy DC/OS

```bash
terraform apply -var-file cluster_profile.tfvars
```

#### Advance YAML Configuration

We have designed this project to be flexible. Here are the example working variables that allows very deep customization by using a single `tfvars` file.

For advance users with stringent requirements, here are the DC/OS flags examples where you can simply paste your YAML configuration in your cluster_profile.tfvars. The alternative to YAML is to convert it to JSON.  

```bash
$ cat cluster_profile.tfvars
dcos_version = "1.10.2"
os = "centos_7.3"
num_of_masters = "3"
num_of_private_agents = "2"
num_of_public_agents = "1"
expiration = "6h"  
dcos_security = "permissive"
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
gcp_ssh_pub_key_file = "INSERT_PUBLIC_KEY_PATH_HERE"
```
_Note: The YAML comment is required for dcos-terraform specific YAML settings._

## Documentation

1. Deploying on GCP
2. [Upgrading DC/OS](./UPGRADE.md)
3. [Maintaining Nodes](./MAINTAIN.md)
4. [Destroy](./DESTROY.md)
