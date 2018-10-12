# DC/OS Open Source simple cluster
In this example we spawn a simple cluster with just one master, two agents and one public agent.

# [`main.tf`](./main.tf?raw=1)
Just do an copy of [`main.tf`](./main.tf?raw=1) in a local folder and `cd` into it.

# `cluster.tfvars`
For this cluster we need to set your ssh public key..

if you already have a ssh key. Just read the public key content and assign it to the terraform variable. Also you should set a cluster name. It gets tagged with this name so you can easily identify the nodes of your cluster.

```bash
# or similar depending on your environment
echo 'public_ssh_key_path = "~/.ssh/id_rsa.pub"' >> cluster.tfvars
# lets set the clustername
echo 'cluster_name = "open-cluster"' >> cluster.tfvars
# we at mesosphere have to tag our instances with an owner and an expire date.
echo 'tags = ["prod", "staging", "kubernetes"]' >> cluster.tfvars
# we have to explicitly set the version.
echo 'dcos_version = "1.10.8"' >> cluster.tfvars
# we can set the azure location
echo 'region = "us-west1"' >> cluster.tfvars
# set the google project id
echo 'project_id = "massive-bliss-781"' >> cluster.tfvars
```

## Setting up access to GCP Project

To access your GCP Project from terraform you have two options:

#### Install Google SDK

Run this command to authenticate to the Google Provider. This will bring down your keys locally on the machine for terraform to use.

```bash
$ gcloud auth login
$ gcloud auth application-default login
```

#### Add required google project id

Ensure your google `project_id` in your cluster.tfvars so terraform can launch it in this project. Currently we do not create projects on behalf of the user.

```bash
$ # checking project id exist
$ grep project_id cluster.tfvars
project_id="massive-bliss-781"
```

# terraform init
Doing terraform init lets terraform download all the needed modules to spawn DC/OS Cluster on AWS

```bash
$ terraform init
```

# terraform plan
We expect your aws environment is properly setup. Check it with issuing `aws sts get-caller-identity`.

We now create the terraform plan which gets applied later on.

```bash
$ terraform plan -var-file cluster.tfvars -out=cluster.plan
```

# terraform apply
Now we're applying our plan

```bash
$ terraform apply "cluster.plan"
```

in the output section you will find the hostname of your cluster. With this hostname you'll be able to access the cluster.

# terraform destroy
If you want to destroy your cluster again use

```bash
$ terraform destroy -var-file cluster.tfvars
```
